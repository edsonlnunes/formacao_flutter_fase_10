import { Application, Router } from 'express';
import { usersRouter } from './users.routes';
import { releasesRouter } from './releases.routes';

export const initRoutes = (app: Application) => {
    const apiRouter = Router();

    apiRouter.use('/', usersRouter);
    apiRouter.use('/', releasesRouter);
    app.use('/api', apiRouter);
}