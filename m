Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63F3FBA7;
	Thu, 11 Jun 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190352; cv=fail; b=jrIhhqalj6z04O9rBIQMim8hGnSLmelL86nee+bgEK3J2/Ax/DVWt6E8q5ffW3QCnDMDnAuQ7j43ZDMrW50YbaQVsCZqYNU4evz2kT+wgWs8hU30+MPruYujU3KXKtazDRnS2gcTq0L/H5quy4m/M2mjfMzjOpazlyfVZu7fmUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190352; c=relaxed/simple;
	bh=JhlFADDJkUkF6NGOELX/eYqEYyI2HiVaWUlz559BKsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AGeaNFnMivS21kLy6t5PkFmXxcr70okiEEuctOyrglvdWyupxW3re71z3GFuLxGTcuMeIVnvNDZ75ea30Si3CPndGPJJ3t/v/ZkbG9tCqGRmu6xLoW6OmPVkb6E/Hc1VxidAXZC3RczIpi2OIGgLEIcjmBzofclp1i0xSAoGwRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qOBkbPzX; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qOBkbPzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgYm5q/ezK575elQ7/UzC/CfRBPYZ3s9PZer2pE2El7ogoldsprY1v6an7W261iHIjoG1rjo+uZVzq8jSt32IR1+csRJFqcqZdNeXjYM6SH8rkdKlbkr4AhcqcV7OS3IRA/BsGr6bFIUxj2H6OlTymYZ0kDxXEErIB4EvWXD8TBTx0I0dNfwKm7Qes1Z3xzRueudR07WstXfigc+beKOlWh5fMXPMYkKxBMUVzmqnEEDRTlxq5iEknWkMKDl2O3f5fHY8P2GoCbYCBrUrc7/laYg5Q4zk1QqAfLHlGcYkaTJwj4+l0Xs7KPxBAK5druTPCZgg7CthWrmBO3N7wCDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS9Oe2gPDLiMGqtyzVGD/0MotUvhgG9PNziIEooybFY=;
 b=C19wbM7qCOrsedZx3jY5y5ZmiHKtSKPVRxQFaKClcMZAXkrTuYMUeSSHMwUhDvHb43HsuKFtA8jWqz+tgby/Q1xLsJ1IecUaXFgDjDkn6T14VqJDgGOBmTJLT9nfHzpDh5bYEa8LVF8/l39mDOjgiI2FcZJEwWmg6k+LjEXmIQEzEA7A//rkQDvSki6p6jEUutaqk/QSIi2owxDbXTwFHd13IlnwbbSRQap3kz2wv1MZlEOQKuSYYJGlewM876AoJ83Wa2rK33/GkXgjQ+aNcAY/anL+0AD5RDMCpswfBSa+XCtdPYPRZRNeo8HqqdjaxPgsCOPEsElJsI5/8Dh4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS9Oe2gPDLiMGqtyzVGD/0MotUvhgG9PNziIEooybFY=;
 b=qOBkbPzX9o3EUOPe2+mP8wXbUwkFhD9rj1sGJ4OR61O7lQXEiZJKbQz04VjJayAudScm0bvkXSFNssXc5a5MCBR7GQ49aRzlSp7eiwFJam+cUbu4pBcLbJctQ6qf5OQC+RJRQy3qsxFSxAKugBzsNSvOuPMrKvB+BHcOWM1zucsXoBt0xfe5dKJTkuaptsUMb3aTH2qPVTVR8Rn43wTOyYxQp1g/AgKw+OF0ndp+/tKk51UjDOQ5oTPgftRC/24ckIIQecDSjKY1W1LXFRkFjtmIv3xcgpFKJ5MalDbVtqsGWAlRFPgY4FSTw+71ixOb8pqzQQKD0EQroakkdw6OIg==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 15:05:43 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%4]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 15:05:43 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] fuse: back uncached readdir buffers with pages
Thread-Topic: [PATCH v4] fuse: back uncached readdir buffers with pages
Thread-Index: AQHc7SMrDK6LV6Q58ki3S+oesyW4KLY5bp+AgAAemQA=
Date: Thu, 11 Jun 2026 15:05:43 +0000
Message-ID: <EEAF9BE7-AE2F-47BE-9873-E649F0A151A2@nvidia.com>
References: <20260526152021.891412-1-mochs@nvidia.com>
 <CAJfpegvSrDgTajqWxkgRCkwxNoR6f4NU9cvKvcpThVDX-jmh-w@mail.gmail.com>
In-Reply-To:
 <CAJfpegvSrDgTajqWxkgRCkwxNoR6f4NU9cvKvcpThVDX-jmh-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|SJ0PR12MB5610:EE_
x-ms-office365-filtering-correlation-id: a9175160-6df8-469f-0870-08dec7cae87b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|22082099003|18002099003|4143699003|11063799006|3023799007|56012099006;
x-microsoft-antispam-message-info:
 K07/LW6mtVLEopQickkxkjifSa2UE2cPE7gyGYBA/NCQxi9RyXi7sLQFniyJpgdUlj7mDiv27OMPqL9aqr9ZUqw6Gspq5eTZmn3K13pQKzGax/2eWfZbgS3IhNOR6nwZkgphk8NsQYTIlrk2OzxaSmY+EbsdDmh2Ocp22L6ORrr3hSpPNunuALNvVWqTB2+7X/IdLcQ+Sit+k2sdjRuM8WfWfUGefAB4dfIwGdqugk1gICVNuYWWDfFMkj6V/9VTZn2bk4VSDZQirvD3Xn9FdkeooaDc0UZDt0LQiSliQQASNn1VgOU3lGyRBnQr0EIvthUZG7/+4hfsfZrYXdo0JuH4bNs8QBWrS5C0Rt1xwpMy6pBe3Ltd3iN0fQayl3C5wY/lXO5ACaNf0mtrTk8JGpEh4AqQdfn6+XvHagKEZajLHNhZUUKW5ESsepSGPBdCol9MeCtj5+ZVL9rrXP7mxqrBG6btvt1R+ZT74pnBosiHz0TMNxMDBq3tVobqvdVrubTa/+xh/XRyo0wY3rBz4cgrR9auSQKcd1boajh0yBBvAoUMDzarEiM/z/MyZmAk42fTr7dvjz4tWTCMUnWWmf26Wgva0emGpG+3WZk/VtKiPUY6JFc+M6RBEwVCrw6jDeRgGbsqwC7d9eqNQ0L+glIxlIZKW3No5x96Xych0BaRWvCv3sTlOZf/J9/dyCyFuudBKuuvywVaD4CaVLmOjAbu++oUyaGzmTd2DCtD9s3GETGeMkytXNoHs2FmjATD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NMWktaXTSPIOqwCH0MUcH8ndlMV6xColkDcJeH7p9m/VGFiwE/jB7Pke/1qI?=
 =?us-ascii?Q?FH/m/tfSUP8fWA+yhsycKIHfDEALYmJfCyqEKGLH8Ob9r6qa47fg2tZekkMe?=
 =?us-ascii?Q?fOMdvLWx4v49GTq7mXKbjbs9O5HL6WFMRSGhFlknHfGRmYAg9i21EobWkFzj?=
 =?us-ascii?Q?W4m/eQkWaO74FDGNBUTg9MWsxcCQupJAIAKZevj/DJITvnA1U45ZolkRaLLF?=
 =?us-ascii?Q?38h+dq5wjmqZ31oxcyJqJ7RfLjyLIa+ynrbMars7Cc1iNQzz0edxSTlenJC/?=
 =?us-ascii?Q?7Smm1Jx+tLgEH4bmSW5mknAO83KOuxJXgb1vi9UXIIi0octePbL/r+y37Hw0?=
 =?us-ascii?Q?x/qGNTHeW3HRzIRsPaInaqzwpF4Yk3hTFCm3z/jqJ7XCM/oYuu/FUB6bywFX?=
 =?us-ascii?Q?AFeG79mV1uG2VhTjFFbCyvOFUSgTs90z1BVSZVklqIop0TA6Nslod+Ie2022?=
 =?us-ascii?Q?dcBPEhXlxoJ2PeDWh3Dqo8jtKjmO+qzz3EC7Ibg1X1wHYmLoumx+JiDNUHCo?=
 =?us-ascii?Q?pUpapcpm+E50AEUC9cg1t7WIzbjLN2Pui9KqtFETgzZGUMlNMVg1QGGFMohy?=
 =?us-ascii?Q?dLcWYxYRj2hrPjXZCzC7RH98ofyxlHjBeigqbdXvUcQU9dWRpXBZCAYEerwd?=
 =?us-ascii?Q?JkS8Yu0NMpyUhdb8Fjh3BflhqSd+df+oKqfbRvdY6AJmaD+l2RUnk8zHiV5J?=
 =?us-ascii?Q?vyThYeliq/S2IgE/RE6xbhID3hLVfXsLJGRn7iA6QpwKrbdR4B6rRBHwmnYt?=
 =?us-ascii?Q?/mcEOPFE1JbP6uV5cAl1rQJnumv2Q1xwTxO5YQJwrGPMOiaYwMbWh4sx2rKd?=
 =?us-ascii?Q?s2Mzt98WXBJ/YpTc98pgwZBXh2uZQ9cnRUJjxhXk+/uNFHGlma1FVKV557EW?=
 =?us-ascii?Q?h+GMkI1Ts45ew9BVDFUb/+we5n19dpq1Ny7KuJDHBX7jyKSVb0STBYBxffXm?=
 =?us-ascii?Q?EHZS+QHIgIG3QLCD10x+NwgQVD1pLVEMhJbgu39IhNMT/Mu1tJoU+yIL7A0U?=
 =?us-ascii?Q?EvQQsaxkfZtpFioTILTLZZgyJf+/H7kitbNV9ThEsksSgTA2I3xp96dnEF41?=
 =?us-ascii?Q?ABX6bTI8ptO/F66ObBYiCwANXeqEPr1PQ4DiavF4ei2THaCBJOh0OhDo7PxP?=
 =?us-ascii?Q?F5qb3LTMephYRqQ+fBjkh3Lg1WiBANtcNZ5hZcPWYxsUVFYlK1Y9rcXo8uhb?=
 =?us-ascii?Q?wBi353RPzT7wddzeG2tPqKperxBavi9hudlMYRyZPtbNraesO73R7LhJrJOE?=
 =?us-ascii?Q?xALKzsdaJgXb6YdKoqIwvUC27Q3G+euV0DMZGn315LGzEjappAXdxVDz2huk?=
 =?us-ascii?Q?vQi3ptQG53YIM8cRA/7vAtf9KcUW0oLRT5SdCYs/25vgXPnNmiFGtHYTNBw5?=
 =?us-ascii?Q?P/axfDaphj4Am4+Kr/V7C1XA1G7L6P0tV3f/yXMUW3Nq0DgJ6N8vFku67DsF?=
 =?us-ascii?Q?+JN7IPwj7N04NtTogD1zag5qzhay0zbIZpv7BLcUx8KOg5u3MeOcgpYDcjhR?=
 =?us-ascii?Q?DcD+pV3aoVbxPrWyB4gmENGtqMy7OvEO8QCkj7CkOI2mSgL8bgNt1EpZWFQk?=
 =?us-ascii?Q?NjkWAjza+N4JC/N58B/EtOITK/zFHGPj5FqzXJRsbxX4UC/DCHV7OwEdfwr3?=
 =?us-ascii?Q?6jq2n4QYHb7n2T5VLETeBIS4vYDZuUvDxfxy4Fw5EPNMv3ADV3DGxjDYEfwU?=
 =?us-ascii?Q?pCTn6NTsIXUHsJu/cjcjU2KC9h6tUo9uMVRZYXlzt6v8IJbgwp6uSARywPjQ?=
 =?us-ascii?Q?35Y9I/TF3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1500B0F45C134944B0A1DAF5FC34992E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9175160-6df8-469f-0870-08dec7cae87b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 15:05:43.0616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SquI1yUbvdjfrlUddqiY1sLIW36lbrXye6ruwOqUcmhzQYDwEbyKvxDOX43kIlv2ZZhr//MEqkjpXb+0UJonw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

> On Jun 11, 2026, at 08:16, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, 26 May 2026 at 17:20, Matthew R. Ochs <mochs@nvidia.com> wrote:
>>=20
>> Commit dabb90391028 ("fuse: increase readdir buffer size") changed
>> fuse_readdir_uncached() to size its temporary buffer from ctx->count.
>> This is useful for overlayfs and other in-kernel callers that use
>> INT_MAX to indicate an unlimited directory read.
>>=20
>> The larger buffer is currently supplied as a kvec output argument. For
>> virtiofs, kvec arguments are copied through req->argbuf, which is
>> allocated with kmalloc(..., GFP_ATOMIC). A large uncached readdir buffer
>> can therefore require a multi-megabyte contiguous atomic allocation
>> before the request is queued.
>>=20
>> Avoid the large bounce-buffer allocation by backing uncached readdir
>> output with pages and setting out_pages. Transports such as virtiofs can
>> then pass the pages as scatter-gather entries instead of copying the
>> output through argbuf.
>>=20
>> Map the pages with vm_map_ram() only while parsing the returned dirents.
>> The existing parser can then continue to use a linear kernel mapping.
>>=20
>> Fixes: dabb90391028 ("fuse: increase readdir buffer size")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
>=20
> Applied with cleanups.  Please verify:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/=
?h=3Dfor-next&id=3D2fcb1dd15faba5657b825cc5d54423251c70e79a

Thanks Miklos.

I have verified this patch.


-matt

