import { Router } from 'express';
import { releasesController } from '../controllers/releases.controller';

const releasesRouter = Router();

releasesRouter.get('/releases/wallet-balance', releasesController.walletBalance);
releasesRouter.post('/releases', releasesController.create);
releasesRouter.get('/releases', releasesController.getAll);
releasesRouter.delete('/releases/:id', releasesController.remove);

export {
    releasesRouter,
}