Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A03CC9E4;
	Thu, 14 May 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794551; cv=fail; b=EG7are2eXcPoZX/lVD/vuZ2F34CUO14xWh+uM59NkIRP0mKjIq0Q1F5bHWopPcpCLscbdT1GuvpdZG/9T7P6WP4QmF7jSyQR6vKI0Mba6YMh2DNBztSyvgn+HUbFNxlPH7muyDmaT8ShT3DUVsqAjVlpSQyOB8oz0Hat9KqDPvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794551; c=relaxed/simple;
	bh=UAVnR5hdM+iPgWV4+TiqJyPoHiPy/h35pDAhn7zCCZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOAqw+znOXw12REQpATRSlfy6QrKf5ZouGDbD7Li3bXvKcr7rlp/suZCm06ikK2PhoFNmWdPltyoPeHfCSIdJJzCNGEqRb1Np0P4AyaTTDUBWw679qABN8i9fZyYKKxpifJL1Tkqkbgz/5f8XcjfqaaGGTvVq1AucD63Ij4gl3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hNfExgxI; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hNfExgxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzdWxprzg18kseneMKSa2H7plWcRNk9vLfeyxO3lrVh++8k8Dhu2A6uk266uSvfJvcdbxrWpEFrCdgvUFSuJv43A88UYvCnlUvbmJ7F6zMGIXUItuaO9ZH79OHxwuv4oUyxX8x/y7jv6Js5dy8TCkKrwhgUXxKqTtJ5PdsOnTRRklosaz+M4edl3rFcvuZUxn7NSLLOpJfeCan4/rDd8Y5VHyaVK9C1KUJN7utkz0xv6bmnQHASqU2+zTsboQuMgjEZPHsh5deLNpzVjerA5qXo2871t6BC/eM9GMPWppOSCYUqEe5X8PLFz8Gn/25pFrVMSCf5wPc23tEoqJapxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCxEGJKJJorCSOUy261cpsiV6vYUlxS9+wb1Tm9F5pI=;
 b=VfgBEzL6JvlJa0iMuQzFv0tFoo1RaodvVhYx/o34VXa2AqXHRCN4F9YVrKP4Dn9gw1uc7sluxkrrNsSnb4ao2zYG+hMnm6ElrW47dH8wtEHRyTgGW4zZdVA9+Vy5rjuc/rl7VIHQk813PYKHCuYditagErbmlbnvhT/T2g24j46+fOtEcJxbrZQdoxBmbmfazCsYdm8daLDG4jX1/L1jU6PKWnVahq7vJM+JCr+6Es2iV9Jm2nQfDaqPunpYzBWbH6QjY2QxEgGFLVTL0GBhOUXT5mageP2uu2/DEmKIMDYjW/fzdPcTaygWTqzeLvlWvQcHirvBYoGzIdaLC/MG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCxEGJKJJorCSOUy261cpsiV6vYUlxS9+wb1Tm9F5pI=;
 b=hNfExgxICF6Qeb0bR+DoRoeA0vxG1gos0QdqfYRXrEXZyAgslnD4YjM6ZOarm/me2tP/k5rPrqDPvEE7664Sp67TKgVhOXWa460YBlLY6vZWn9Lq836y4LJBRmOuDBNeEb0K0boBN8L0MvTWCS1Fra19WC5a0BhxgTNmGtXUigAA4Tsx5nfwwkEASL4mKrSNIKfWT7iGdXl2tk2c3WsUt0R7lu6KKPN9sheeZ2yfAQ2qPtlsi6FN4Rugdryf83FTgae+kbUPKDQMuHD8ZGMx/eA5Hu+IMFOnzQio+z+fRTJoP9a0dXVBJoadE7kBdZlbB8/jIARtCGB4m+J7iqRhHA==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 14 May
 2026 21:35:42 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 21:35:41 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fuse: back uncached readdir buffers with pages
Thread-Topic: [PATCH v2] fuse: back uncached readdir buffers with pages
Thread-Index: AQHc12b/q8G90X8MpkGv8PpQTNzx27X1pGaAgAJaoACAFiVYAA==
Date: Thu, 14 May 2026 21:35:41 +0000
Message-ID: <486C7565-177D-4D6F-88DF-B7DFA3DA60F3@nvidia.com>
References: <20260428233028.2747981-1-mochs@nvidia.com>
 <CAJfpegtcsWnXh-uDh1Qu83dFF9nJji1gytk2y9Wk5p9+JDTZ+w@mail.gmail.com>
 <D14CFB43-C7D8-4F3E-920B-E2A3B925E6B3@nvidia.com>
In-Reply-To: <D14CFB43-C7D8-4F3E-920B-E2A3B925E6B3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|BY5PR12MB4228:EE_
x-ms-office365-filtering-correlation-id: 45c9be32-2282-47a5-bedd-08deb200bf8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|3023799003|56012099003|18002099003|22082099003|4143699003|11063799003|38070700021;
x-microsoft-antispam-message-info:
 rVvm5ZJ8IKsTrw2RLf2BNuc4kCKfVu+0VzA+18YGw6pCpg7xeW/4MRBYkeUXKh++etZ5Hx7JfVN9+ZL/JYEi/Z96wTtZmXxCJ60ducQxyphdsiVIUtddULjH8Cq7l11eklN9WS2YrOCL92WYqxEkwv3xYRaFZtTcb8J0Ox1IUHplu4eV+feqwrUvYfUzb4iyWNslxFa0/3FpKqEklvaQn2s41Dn2ku/E4UvvokcgY4UFs4H1upISH9i+QQOASTfPO0WCy1pTagC1rcHn7nhYs9QM39dwlc6jILbVZ2uylt99rBAb9Tyg+6ObSq09bsnm7+MI/Hl2lo6z6RkzINoZEw1aY1ar+o4hCTyHbIvjRwHBaKGyeTCQtmFpUPAsshDXFGtIZZr7JGR9872om/bn/jkBxBXk+zVjnv+4vyyV5Xo0H66xqwYC1XprX+EGCLSGslaOuEWciksykPiJslwza5V8rDH8YAocW6cNgON2l8Z8XhiRe4Uzo7ruE6zFJ5HtLhjwzVre3llZn/cQQS4hBtsA/xtQQJhLW6zEDUWDIX8KkHBKqCelMJVtq6QoB7vGJ4sjAOT3SqcTTm1qawd1zkCB6ScN9drcwLDRepnfzFrxPdDD7SNUnWixlMbQfn8l6MJmPnMhv8QiM2R7Vg5f3gAOwyliE7z1A2YZ4wGj2bGLuh14pwy/7qnoHSob8TBnrmkXbZNv/AJGcaJOCIjScWQAJRyujkwhOMzpPbttu/Wa7rjmHHvvAtRKBH7Phzoz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3023799003)(56012099003)(18002099003)(22082099003)(4143699003)(11063799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vBeQbwMItdGYezv/L6slOdNSACISUPSWwE67VfU6voWVTxS2KN+DEC7YlcH2?=
 =?us-ascii?Q?GVTwNn7UkNYrjyCfUYKLncMO4xtBCF2o/64vx/HLMXXQQVnPnnJvU/a9njsn?=
 =?us-ascii?Q?A1Fk9DsQ91bMIZL3aZG4HdpbMHceltkLqKurDez9DiGBjn1bMyXpbLI5K9vu?=
 =?us-ascii?Q?bnWwdO4sUzef2vf+0Q0mKE3ktu5v++eIP6HFlcu0RFJr9+THJMmBe/gCp7vK?=
 =?us-ascii?Q?mKqdDv5v+5U1gS0YG9fCYAN3Kw+jo/0YQkxXr0/8ligDCQss/7PivaYGtyoM?=
 =?us-ascii?Q?IES4M8CBJ4jvZ4AMK5vdGu3xLUW3YgUgwuTmnw0WEVTCB54OSFmP92p/4w1Z?=
 =?us-ascii?Q?MkBmKwCGeZVQRMJiMhc3cT5Lor8vrmJ4/2kBUFivHer2ssLImIg4Z4VRxVtz?=
 =?us-ascii?Q?k98/FNfsDbB7DL7Ih/4xLJzANtV0rNUdJ+w3MzaGGqiH08Dt/cRbtkMBfJEB?=
 =?us-ascii?Q?sBwlu0TZzDXyOwDUSQGTHrQ3s6LpOMx2/KeHzyrsveBOD0cDulOqBjbCjrw0?=
 =?us-ascii?Q?SQpJyxc3M/ZkwxEfvi88DmK35Jj2gG4O9r3t8fbevaOLy3vF8fVMs3nL3Cah?=
 =?us-ascii?Q?bd51yczN5MtNbt8CBXyA85RBjOX0YkHz1+PTJj/KoVbsR6yIluwYRNJQgBhw?=
 =?us-ascii?Q?Kx9epyfhFUQ5w7fHcCW2cKcZY27hj6p2JmnaIS/VOb5lmxAy3gOxNdmfDrNA?=
 =?us-ascii?Q?f9o4suAvEnIgPIW1ewnNJO6xQcjgPmG4bHe8sTpp9G2jfsxlQ+c66rE/jYyv?=
 =?us-ascii?Q?ZqhbIgb+GKMUiviuom43/FfGZ/wjf6nbU9w+D94KcrmNWE8GRoex0zpbSHJs?=
 =?us-ascii?Q?0Xrqoa5jefHRUZ8mHZ32+pe6UGD+9qE4ApKd4PUgKorUE8/4lH0WG/i8vRfR?=
 =?us-ascii?Q?lYqw6ZQ1ICJIy0Z3X8MxZf24N24XHJ/iuOe17Heiefg4JnAS9kBcIr6YjKfu?=
 =?us-ascii?Q?AQ9kb0a+N9FuVMq8pdB5pOzYInKT9QKbYx5yzEmNbvYBycdC6nQoyC6fvbtf?=
 =?us-ascii?Q?EwW0oYmdfJ9Es527u4AmhqyS34eFdtzRDh4H2E6xwi0mikhXNcOdjzNByWbf?=
 =?us-ascii?Q?PvqgXWfST0ic2gLb8X3wSTgcNpabtQjkzGnZ6vpCzFI6TCFJwtV19DAipSTc?=
 =?us-ascii?Q?O0wdQmwGA9qMEDYFtkwjodjqKUvqhzYB7Hshq72Pww0LPdxB2v/C3TIJM/2d?=
 =?us-ascii?Q?Ys5g9+cSyaGL2bnzRFsbQ91hUYqIBe4E8y6AeuAnx3DBQPqetGpSZoG9LQ9e?=
 =?us-ascii?Q?TznefwXtvA+cV+2E87oUPkI+9ddBYOxdwcI//b2i+Qya/U7GGKvTmtqHj19w?=
 =?us-ascii?Q?fR6rmvWObaaTGNLaFFRZOUz+V83pF5cGYt/qL65k6Lzl+oV739kiDuMxuyg3?=
 =?us-ascii?Q?6Sh31qpmVMx+aDiAJd7rFzr9Va2LEBSFG7dRfvGJaVFIMdl1A3Y+acsJpGPW?=
 =?us-ascii?Q?KcaPDPUirK4RoTzu7QRIw+OOKUnkHeQ0+TCkKyhKACUJoq95EJdVmuaMs1Cy?=
 =?us-ascii?Q?+OMwspYuMr+dlnE9eGp719aJYS0AfrMiCgyao+2UC+DVKdh5FPKcCR+ZXe4W?=
 =?us-ascii?Q?B6+/EHRi95NH6O/AkFFpmz3rcs73azdOGbHqqhdHjs56XRHpPX5jkL/4L1QK?=
 =?us-ascii?Q?RLBB5EOKuqFosNdSciOSblKCuopQESgJJXwUBPidyn24g9Uqv2MSjBDw4/zz?=
 =?us-ascii?Q?LnqbeGQwN/FeNrJ811+RutJzNnArPr3cbNRagYA18P8IMtfxpmBebfpllgka?=
 =?us-ascii?Q?3H7mRElK2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <923474A9DCD38E4CB7036FC8B0CBF249@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c9be32-2282-47a5-bedd-08deb200bf8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 21:35:41.6400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRQFOXJfPKa5aPkIIIkN/Psvs+2B3Po3rfujhodiZCK4cgbsZTMiM3ODFP5BGHezjorlwU/aw+9CFmWFV+IWOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228

Hi Miklos,

> On Apr 30, 2026, at 14:24, Matt Ochs <mochs@nvidia.com> wrote:
>=20
>>=20
>> On Apr 29, 2026, at 02:27, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>=20
>> On Wed, 29 Apr 2026 at 01:30, Matthew R. Ochs <mochs@nvidia.com> wrote:
>>=20
>>> The larger buffer is also currently supplied as a kvec output argument.
>>> For virtiofs, kvec arguments are copied through req->argbuf, which is
>>> allocated with kmalloc(..., GFP_ATOMIC). A large readdir buffer can
>>> therefore require a multi-megabyte contiguous atomic allocation and fai=
l
>>> with -ENOMEM.
>>=20
>> Shouldn't this be max_read?  Here "read" and "write" refer to
>> direction of I/O on the filesystem, not on the fuse device (see
>> fuse/file.c)
>=20
> Thanks, the read/write direction point makes sense.
>=20
> I tested changing the cap to fc->max_read only, but that reproduces the
> original virtiofs failure on the 4K-host/64K-guest setup. The runtime
> values for the failing READDIR are:
>=20
> PAGE_SIZE=3D65536
> fc->max_pages=3D124
> fc->max_read=3D4294967295
> fc->max_write=3D1048576
> max_bufsize=3D8126464
> nr_pages=3D124
>=20
> So for this virtiofs mount, fc->max_read is effectively unlimited, while
> virtiofsd advertises its 1 MiB MAX_BUFFER_SIZE through max_write and
> rejects READDIR sizes above that limit.
>=20
> Do you prefer handling this locally in fuse_readdir_uncached(), for
> example by capping the request with all available limits:
>=20
> min3_t(size_t, fc->max_pages << PAGE_SHIFT, fc->max_read, fc->max_write)
>=20
> Or should virtiofs/FUSE instead make fc->max_read reflect this byte-sized
> buffer limit before readdir uses it?
>=20
> I will address the other cleanup comments in v3: drop the cast, keep the
> clamp-style sizing, use release_pages(), and remove the nomem double jump=
.
>=20

Checking in if you have a preference on how this is handled?


-matt
