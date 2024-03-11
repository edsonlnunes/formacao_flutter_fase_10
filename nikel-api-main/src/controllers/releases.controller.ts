import { Request, Response } from "express";
import { Release } from "../models/release.model";
import { releasesService } from "../services/releases.service";
import { extractUserIdFromToken } from "../utils/extract-user-id-from-token.util";
import { badRequest, internalError, notFound, unauthorized } from "../utils/req-errors.util";

const walletBalance = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const userId = extractUserIdFromToken(authHeader);

    await releasesService.walletBalance(userId)
        .then(release => res.status(200).json(release))
        .catch(err => internalError(res, err));
}

const create = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const userId = extractUserIdFromToken(authHeader);
    const release =  req.body as Release;

    if (!release) {
        return badRequest(res, 'INVALID_RELEASE');
    }

    if (!release.value) {
        return badRequest(res, 'INVALID_RELEASE_VALUE');
    }

    if (!release.description) {
        return badRequest(res, 'INVALID_RELEASE_DESCRIPTION');
    }

    if (!release.date) {
        return badRequest(res, 'INVALID_RELEASE_DATE');
    }

    if (typeof release.isInflow !== 'boolean') {
        return badRequest(res, 'INVALID_RELEASE_IS_INFLOW');
    }

    const walletBalance = await releasesService.walletBalance(userId);

    if (!release.isInflow && release.value > walletBalance) {
        return badRequest(res, 'RELEASE_OUTFLOW_IS_HIGHER_THAN_WALLET');
    }

    await releasesService.create(userId, release)
        .then(release => res.status(200).json(release))
        .catch(err => internalError(res, err));
}

const getAll = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const userId = extractUserIdFromToken(authHeader);

    await releasesService.getAll(userId)
        .then(users => {
            if (users) {
                return res.json(users);
            }
            return notFound(res, 'RELEASE_NOT_FOUND');
        })
        .catch(err => internalError(res, err));
}

const remove = async (req: Request, res: Response) => {
    const authHeader = req.headers['authorization'];

    if (!authHeader) {
        return unauthorized(res);
    }

    const releaseId = parseInt(req.params.id);

    if (!releaseId) {
        return badRequest(res, 'INVALID_RELEASE_ID');
    }

    const releaseExists = await releasesService.checkIfReleaseExists(releaseId);

    if (!releaseExists) {
        return notFound(res, 'RELEASE_NOT_FOUND');
    }

    await releasesService.remove(releaseId)
        .then(_ => res.status(200).json())
        .catch(err => internalError(res, err));
}

export const releasesController = {
    walletBalance,
    create,
    getAll,
    remove,
}