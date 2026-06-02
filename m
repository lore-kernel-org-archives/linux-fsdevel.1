Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FE3F0A81;
	Tue,  2 Jun 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411501; cv=fail; b=fkPbH5JaJyYPIOnSFNKkqfO5ds1LmeepqxAil/UOh37MpnnFjAwUMmLCpnP5wnNXqvKrRmihHXItmcgK9Bg/2uEvWbquEtjS9QBJ8+PIcajMCCWb4S4IHRhnOTsowrrOsOOpvzdCRsVsOlfXoQ72HtQSAhZMHkOu8QyBvL9tczQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411501; c=relaxed/simple;
	bh=Ya0DcuMFYuvvmvKTBU/H2Vruq585277YbsNl09HJtwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ff14p+BdtK1MS17fLCSo/ODvYOIoDrCRdDTkBf2Ahw1IytE/3NS2adyy4pOcpvlKV61IAIockYuBwE4qd4fm2wRO98tTJBFxtyHqOIzKwRX3qf1HZfMSq3JNMZluEBAAHpZg1sKeRa8nVzTXRHo/G8bOuY6Pvc2l9T77Y6TwgJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EAb9e7Qm; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EAb9e7Qm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtSHNxGwXdyWIcgKcNr8Pd4MRW5qFSVQljjUW5XMilMzPH8CTAot+Odgojh/7secEXROITRHw4PsvIL1Ft85kQkXtqhtWVluHXcGbJx+5okQSQj6Q3PH/591W7LD1BaoDf+UKjRLhxfgOXz2uoKyNdSCO4YoKo4kIIVxgErffPji06gdq6VmkloCiJOaHhfWupOD8WFz5qlHRuuUDSpia1W6tEgmxFx6mskbLhUppPXUDceVe5orzFZhsIH1bf01rdoqzngMCd9wNtJ6hZN5TN3K8lNzrEkuR7ArHFvIwP2DZnHFnABfWwWGXziX9hwEjsBP7S83vulzQ08QXljWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8YbX4INPPl7zfprYT/O/Vc8WLrZnM2yh3fsNNZkMzc=;
 b=Ls14HKN5v4ofHdvhMZCSVEkbpg0UaKGxh3u0YBk2+rSfCD7Vje+XsFpLYWFHIVY6wQWggoPID61Hn+HQia4itS5rSDpPo94+To2wqgb6zxnFU8RrLlv7yrVSHXNFJOJay6cOSPbDPypNiWdGOSnVa6xEOkE9HXWtAHFYM4FbzQzzYF1PouOaaBMjISw52tSbnJzpHP0hvbW7Qeu08IM/fF6ps8Da2eRx46EmAparDXJScPQ0CPeU+qJ5twxFXYUp9RqnJY8ShCBe3z1csotRsmNuULadKQQ34HdlkSsKx3NNmhQiF5KH6hvUIXN+Y9l/YWZzGSAlYLhSED90VUwsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8YbX4INPPl7zfprYT/O/Vc8WLrZnM2yh3fsNNZkMzc=;
 b=EAb9e7QmNQIC6uVMNHEK+w8vhiueM9jG1cbEBCAMFYAjqcxfvg3ucpLsVwRK/vt9Z25ZQSqHOnFkS5YmG8fxlgN5sFEEAazFy3ZhFK7AoCcA4bQ6APRf+3bcCwOgil73LyVfo7EkXKAgbil9YkZ+/jMFz0rjofdXlHIiCQ8+M8IbzWbffTCLnb4KpIlDoF+4XqSdpCaaMhfXB/ggGlkOSvqgMH3QA8W5CQeDfO4A7pJjQ9nBmJLwJ67VA412nA3i6KY1maOQzqsEwYBcTu+J9XcwPfRec1l9XXIFt58qPvL133t80pzGmPFL93wfWRKRxSLBJygKg5jOcIsA2PxJBw==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:44:53 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 14:44:53 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] fuse: back uncached readdir buffers with pages
Thread-Topic: [PATCH v4] fuse: back uncached readdir buffers with pages
Thread-Index: AQHc7SMrDK6LV6Q58ki3S+oesyW4KLYrYmoA
Date: Tue, 2 Jun 2026 14:44:53 +0000
Message-ID: <055064DB-67C1-424D-B6E6-0B9C3E326267@nvidia.com>
References: <20260526152021.891412-1-mochs@nvidia.com>
In-Reply-To: <20260526152021.891412-1-mochs@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|PH8PR12MB7326:EE_
x-ms-office365-filtering-correlation-id: d94d4b7c-3caa-4050-cb7f-08dec0b5821e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|3023799007|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 IjUNslQSrdyX/8HHLW5dgUCbGPxTffv8CkOHQzKCYkjVrdC8d8WbOUIvMgAKAmSvDwQa9mNuj6PGf8AvML8d9GvbjXSyNrgGWudT1S6juHKcnClu9Fh7ulDRmYqWxwwDnyrOOp9QJ+9DBIU0V980ZcCL7XnwWTmxuNVYdCb/tjRCpzkX1SG3jvkW4/43r7R9e+5FKhaOfXqj/Q9z8rG+X9QwPHpF4P8yzSB+v/zMOjpkqIXn8V1LvTMs9efNrX4QPC2udSwV2zHmKGNjCTIwTo1fCanwkAWK7xTzCi6i2a2QFaH55DHNO9l3K96pFUh3P2gxKOPFoozdzi/wqFkAZS9wyUclH4qq10DS97FYFt36+6QF+npDFzuajgF/lc+xlxlO57Cr/VH+KWakfaDwLIp5+SeR3+LuHxbTOu7D8MlJwa7KH2VdhCevfUz0ZnWQ8K63HupKDN3TRdYYr6vr/hg0Ts8M8zux4WV8zAzxKQPFkBE0aG2qPCrBhJe8E8V1QzZ0pxNueIjzJpXsdnyy0tgEIrjCTgZ4xq6t8JmnDLh0663/nxYcCSnKe9yXybxAj0ulgQPgQAWGBk4Na9kH9MtcSs7XfveosFFlfF5ujHgjNHwWYvsavRpjTlioaPstnsGAM3qkb+YIUG6kYQjmEsJRK8nQ+gGKGoWERPC4iSciyS2aYtXymmqOhSeUZ5du9vRovHEAQqhvj8JiTUCrRRPhezKNgnTZ0ui+e1rhcZyB5Y88PRJ5BURfqk4Pja1K
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sDSPc1J1OaE7CHuoHvMNcexLQJh04RmJBp9R9NpmL79mqzeMrkDW1JRty3E0?=
 =?us-ascii?Q?2UeuBCiL4fgdijexZVg49N+yZR+/iAwopmFFM+8vMiMAGWYjgBR6ymZ5iiAE?=
 =?us-ascii?Q?/YtzgHljJ3/YvLQTgIdX4wkKd+Y2VhpSrePzQCHZKnjLPLggovBi8yv3RtG4?=
 =?us-ascii?Q?DTIoqpiNh0GKUQ0hQ3bRbZ5dUrLdO97uzG3Ex3A2hDT1Xu2dAQiJTkGOKMLR?=
 =?us-ascii?Q?uDtpN2r0otSLb6nvFc9LvgT53ck5jXw9sxwXJTDGBLMBhQcokEEfwY2e/J5j?=
 =?us-ascii?Q?2w8XaAT1p4A6GUzjXSC126UfgrSL7zsJCY37rVhrDUybhnTVKsGxFiPgh7LE?=
 =?us-ascii?Q?bT+P25AQr7+57Pt2c5AGxncpgcudC9b+dQMHKTQGE0xzt9Hjvum0k1sixv61?=
 =?us-ascii?Q?Qpp5XraWtCRfqyExczknk5FpDhVv5xBdX9iiKmUVQPD/wFKu9wbN+31k3lgJ?=
 =?us-ascii?Q?B/BWF1Yz6zHuUsSeiKh+mxw5NeJeTKx4y9eKMvCsChsvd/50Id0ZcdsfkSFr?=
 =?us-ascii?Q?qC/l1CCLljQi2qab0AELbDHerlX2Kv6BaQbFNcizu2KkSGEzKwVSVvOw2Gbx?=
 =?us-ascii?Q?Hk7k8kAWofo8RJg9boIs5C0Wc3Eo+MLfTu9r64v5IJvOeFDJUIM38l8BNdtz?=
 =?us-ascii?Q?ezoG6QwiXNakWiwDtYjslXWErhzUt8AkcmAIw13j0ey2WN1tx4LqBOdq2uT3?=
 =?us-ascii?Q?UYr6lIUwO7AkwfZIbH0KR6vRDlM288XulVCcv/imYAmvNq9K5IkbHcQSTL5v?=
 =?us-ascii?Q?jwq2BLPmgvMDDbgSXZ3IsVUsYRUjrxloXD2HZNOEZe790xJEqVDlwO+iJYlM?=
 =?us-ascii?Q?z/YeF/7+o7/X2ddwZ8Nsj8dVp2F+wOayFJq9oqOYiMoH1wpsZKRpWGeHOQk5?=
 =?us-ascii?Q?QuQ3NutOqGb01z0sS9wI6U7waGk8BjwvFvu0Q00qzki8cSobULpJn6gjZCpL?=
 =?us-ascii?Q?xXwd1RSVzEAdkd/S3aBepusRnmGqbJnTtM0XVx3jKeeK4JXx50U346SfJMcm?=
 =?us-ascii?Q?w8iYBFJMcLYKeOzF1m6GEBaW5wf7PPwnvMb0NN2WLJ58GqCZw2UBfTlZVfTS?=
 =?us-ascii?Q?qqagzBAjYN7b/hLmS/Cl8H7bIN3iZcyWH/eCMrfuNb7lOjQRzYAiE6rqlt4U?=
 =?us-ascii?Q?OwSvW+Tl4WuBXchMjbR3TLPBT9t0iZS65tSB74DQ70818jDLLDunVWDMENci?=
 =?us-ascii?Q?IWL4AxM5LPmqGpfQhFlGeOTlX8Gb0Nfo8rsmvuZ+SiYPuc6XjSSn5hRiUC+P?=
 =?us-ascii?Q?Z2miA/FbSQah1XCUu0AlPnSdQrZ4A6yD3G2gIizMr26YPFD+aoXbCjcWYsDr?=
 =?us-ascii?Q?7HLNUr/2I8riU49nXWbFZtJYn7kiiOlKPKzz1ROcgC6BYL2pdsS9JWpFdcRp?=
 =?us-ascii?Q?XGgoQc0JbQHNaurNaEEfg241vEpAivwe/VMPY9QrXQplEwl/t3CvKOj5LNRa?=
 =?us-ascii?Q?K2kvfad7BBfXNhWuK0GdlbjaYI5Y+0duPHf3TRxFyCnkC321GoBM1xtomOmh?=
 =?us-ascii?Q?Qqns27Ms+1eibnCvIbjf/zIl5BWdiVJLBcJqxW2NpW3v5IPRoWoW6dSkHtrQ?=
 =?us-ascii?Q?5P12FtaofAQdDQ+VtvrlAAe5Cim+hORDOCmHcFU5wWZhzhRf/3+EWX971yEO?=
 =?us-ascii?Q?l6pdXa7grlyTScuyQFGCoxSTaK6Qh/SeinOq02xhl+7wPZkh65Qml2CKuQO8?=
 =?us-ascii?Q?NGU2foZR1LdD6mxEgQ1bY1D5Cg9LuVrBAeoMbEg7lSqvx6kl7qXjGZepfGY4?=
 =?us-ascii?Q?2/SxriIfkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E9664104095414B90B92C7E9CFD7CF8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d94d4b7c-3caa-4050-cb7f-08dec0b5821e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 14:44:53.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 668IxS8Px04+VqtYY72F+3GQECkscauu663/AriwKOVBI5RavNPLlXS+pNbu3wKV5Ud4TfgAlh/MsOoF9caOBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326

Hi Miklos,

Gentle ping on this v4.

I reworked it to keep the kernel change limited to backing uncached
readdir output with pages, and dropped the request-size cap as requested.

For context, the separate virtiofsd-side issue we discussed has now been
fixed upstream in virtiofsd:

https://gitlab.com/virtio-fs/virtiofsd/-/commit/d24cda8a325d2a9ae1adc5acda5=
7515ed2e8e1d2

That should leave this patch only addressing the kernel-side argbuf
allocation path for uncached readdir.

Do you have any remaining concerns with this version?


-matt

> On May 26, 2026, at 10:20, Matthew R. Ochs <mochs@nvidia.com> wrote:
>=20
> Commit dabb90391028 ("fuse: increase readdir buffer size") changed
> fuse_readdir_uncached() to size its temporary buffer from ctx->count.
> This is useful for overlayfs and other in-kernel callers that use
> INT_MAX to indicate an unlimited directory read.
>=20
> The larger buffer is currently supplied as a kvec output argument. For
> virtiofs, kvec arguments are copied through req->argbuf, which is
> allocated with kmalloc(..., GFP_ATOMIC). A large uncached readdir buffer
> can therefore require a multi-megabyte contiguous atomic allocation
> before the request is queued.
>=20
> Avoid the large bounce-buffer allocation by backing uncached readdir
> output with pages and setting out_pages. Transports such as virtiofs can
> then pass the pages as scatter-gather entries instead of copying the
> output through argbuf.
>=20
> Map the pages with vm_map_ram() only while parsing the returned dirents.
> The existing parser can then continue to use a linear kernel mapping.
>=20
> Fixes: dabb90391028 ("fuse: increase readdir buffer size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
> v4:
> - Drop the fc->max_read/fc->max_write request-size cap.
> - Keep the existing uncached readdir buffer sizing logic unchanged.
> - Limit this patch to backing uncached readdir output with pages.
> - Update the commit message to describe only the kernel-side argbuf fix.
> - The remaining 4K-host/64K-guest ENOMEM was traced to virtiofsd rejectin=
g
>  READDIR sizes larger than its MAX_BUFFER_SIZE; a virtiofsd fix is being
>  handled separately.
> - Link to v3: https://lore.kernel.org/all/20260519004746.3203156-1-mochs@=
nvidia.com/
>=20

