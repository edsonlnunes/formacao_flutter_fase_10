import { Release } from "../models/release.model";
import { formatWalletBalanceValue } from "../utils/format-wallet-balance-value.util";
import { dbQuery } from "./db.service";

const checkIfReleaseExists = async (releaseId: number): Promise<boolean> => {
    const releases = await dbQuery(
        'SELECT * FROM releases WHERE id = ?',
        [releaseId],
    );
    
    return (releases as Release[])[0] !== undefined;
};

const walletBalance = async (userId: number) => {
    const releases = await dbQuery(
        'SELECT * FROM releases WHERE releases.user_id = ?',
        [userId],
    );

    const inFlows = (releases as Release[]).filter((release: any) => {
        return release.is_inflow === 1;
    }).map((release: any) => release.value) as number[];
    
    let inFlowsTotal = 0.0;
    
    if (inFlows.length > 0) {
        inFlowsTotal = inFlows.reduce((count, value) => {
            return count + value;
        });
    }

    const outFlows = (releases as Release[]).filter((release: any) => {
        return release.is_inflow === 0;
    }).map((release: any) => release.value) as number[];

    let outFlowsTotal = 0.0;

    if (outFlows.length > 0) {
        outFlowsTotal = outFlows.reduce((count, value) => {
            return count + value;
        });
    }

    return formatWalletBalanceValue(inFlowsTotal - outFlowsTotal);
}

const create = async (userId: number, release: Release) => {
    await dbQuery(
        'INSERT INTO releases (value, description, date, is_inflow, user_id) VALUES(?, ?, ?, ?, ?)',
        [release.value, release.description, release.date, release.isInflow ? 1 : 0, userId],
    );

    const lastReleaseId = await dbQuery('SELECT id from releases order by ROWID DESC limit 1') as any;

    const releaseDB = await dbQuery(
        'SELECT * FROM releases WHERE user_id = ? AND id = ?',
        [userId, lastReleaseId[0]['id']],
    ) as any;

    return {
        id: releaseDB[0].id,
        value: releaseDB[0].value,
        description: releaseDB[0].description,
        date: new Date(releaseDB[0].date),
        isInflow: releaseDB[0].is_inflow === 1,
    } as Release;
}

const getAll = async (userId: number) => {
    const releases = await dbQuery(
        'SELECT * FROM releases WHERE releases.user_id = ?',
        [userId],
    );
    
    const mappedReleases = await Promise.all(
        (releases as Release[]).map(async (release: any) => {
            return {
                id: release.id,
                value: release.value,
                description: release.description,
                date: new Date(release.date),
                isInflow: release.is_inflow === 1,
            }
        }
    ));

    return mappedReleases;
}

const remove = async (id: number) => {
    await dbQuery(
        'DELETE FROM releases WHERE id = ?',
        [id],
    );
}

export const releasesService = {
    checkIfReleaseExists,
    walletBalance,
    create,
    getAll,
    remove,
}