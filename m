Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66085274B3B;
	Thu, 30 Apr 2026 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577065; cv=fail; b=dJjs3bWo7rRX2cSSmb6JWESdrj38U5EGpYE5ZyH7VLK/yq7TzQVpNAFC+INJUemJ84WdvvEo1H/pYe7d+vKThqPZNyZQvnLyY+yLXVZYm6ZDrh75/6S1lZbQY+U+q5Dxh0QKIB2xCAi0cNdPfziSLMnaFcRFpYcrfkEFLQqR8ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577065; c=relaxed/simple;
	bh=QL57qeF6x3uRRF8WHkgXEvkdUlKVGLWoP+vC/NV+RDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LvgeOsUyXl5K8/jONO3iqvXucfNDBeM+Pa5LWXOri8iEgfMC+MujexQIE1y7H3e1ocjKqa/xy//l6qp/qjDIpC/eeM2h/cas/hg/9rQ8AnuKrFNytrJYSEVjel+7aiHKF/wAGtVCCn+3LJ40lLW+aZyyX+8Nw8azQ9A6vnwEh6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T5LKIaOv; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T5LKIaOv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFS5Z7+nZ0o7DirAO7TwawWPCk53jEcLxP73oPhncoZmS6wrbZXQSH3Uw1bf4qsAWrW+U8EOUDVWIPNhkzzw+wLeXQKv8a+Am9hieXvPeQ9NZWLRd2bSsoKNa62sJ0SLuBABW9WcDegvacM8LdS7LmiLyenvbPKZx+VqtQSxa1U/ANKEFOt9f685QHoApIDmp70a3Bvm0DxAOvOncRX3fargv4AFSQmp7RsT4LG4QocTm9BcreFYThdoXIlu8iYPAwvIhIhsN4Jtv5Gl3EBYFOIZ7UoWliEPX0VkXxExBejQLAeqRBSg4oZFcHLjsYY12rByJ3xliyti+ljpJz6hJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+uwYBl692OJSUPvRl++0tGDA49Cm8Lxm/cPaoIXEiU=;
 b=uSRm0kbjio/2L/vnX3InHe877UDcvByW2vgTfSBSrlOoSTAXqRM35EeCkdFrBUZrrOKiP3/fFW1MxWk4yZ9j8fwqVG8KYTljvb04tUq7vnjBytvmaB6UBbbFNv/8dikHGO9l7h/qZ9BiGg9N60Qt9EqVtwq6bCvnkQqGowfvC9KGdqM9eOXzewbWquiCUdh+8nvTohIPfn0PvFvyVOYaXx0XiAe0Be2oc2K/5K0mEQMm22TNE699GNOW8SfIYHW6DUcw2/Va9XLSdH3ZQ0ZG3CE22Tqcs7H3KhiVjtQbATKmVBUvxbv757JIWJs0L9T8gwyHYH2wjVKO6aw+1b9HEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+uwYBl692OJSUPvRl++0tGDA49Cm8Lxm/cPaoIXEiU=;
 b=T5LKIaOvtYePczYW267q4Sx/aoI16lUC8fbkVk/8kTWP3YUz6cX6E9Kfa2DpEua4JRoP5DI5YSlsTS9hl5bJWYWTByZcJblQ3Vtk1//LDN3bj3qJV/JqZaxeIdJ8FIpyt13Eg2P13yKZFiSy/Chz/fDqeXPJoW/82WUzLuwB2VZsO9h6+9RafoNbHFQCuHQWzV1sybQEqgVy5PmMSJ8KytsMgPJAkVdG2iLC7zym6nw0Q3kT3rxDGaQPXeJkigEI7k7PYJ7gszhkm1ZLgRSP2sYVsZIv/QMHDm7ickUl75VDwApOIyhrR2PTJcNa6Lzb0B3NMMSRAySZthb8Gxf9tw==
Received: from PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 19:24:19 +0000
Received: from PH8PR12MB8431.namprd12.prod.outlook.com
 ([fe80::d6b:1180:9eb3:dd70]) by PH8PR12MB8431.namprd12.prod.outlook.com
 ([fe80::d6b:1180:9eb3:dd70%4]) with mapi id 15.20.9870.022; Thu, 30 Apr 2026
 19:24:19 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fuse: back uncached readdir buffers with pages
Thread-Topic: [PATCH v2] fuse: back uncached readdir buffers with pages
Thread-Index: AQHc12b/q8G90X8MpkGv8PpQTNzx27X1pGaAgAJaoAA=
Date: Thu, 30 Apr 2026 19:24:19 +0000
Message-ID: <D14CFB43-C7D8-4F3E-920B-E2A3B925E6B3@nvidia.com>
References: <20260428233028.2747981-1-mochs@nvidia.com>
 <CAJfpegtcsWnXh-uDh1Qu83dFF9nJji1gytk2y9Wk5p9+JDTZ+w@mail.gmail.com>
In-Reply-To:
 <CAJfpegtcsWnXh-uDh1Qu83dFF9nJji1gytk2y9Wk5p9+JDTZ+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB8431:EE_|MW4PR12MB7481:EE_
x-ms-office365-filtering-correlation-id: 0103ca96-4559-4fc7-51d5-08dea6ee13cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 /eEfqHfSqhfOjt3fvcJe5SYapt9Gf6rbnFxh2snwYsXOkVF41sG6GpgtJwev6r4fN2uoZDLkR/QlWLXWEWzIM5RUXBnQyE7j4PbO1AKaMnxEcgUsmFCbf3Ks0NMq82fJ0FYxaoPU4Dob2Cf9q4FmzD7nqEb7iJ985sPP7tD1zqQ5wLw2PHgA39tbfWnPnOmfJUPX6qbuSLlu7Og2eIWBo8jRzn3dNFfHR+CJTy1hhfdBAw+GtElVJqnGnfK5tweWw7SFzsWfcVPDFe60m7bihile+50G/lzx4+ml2ELf8JByOZVn/9oUTZcV1i382YxAs+xaTp/PjowWDkUWGktnZdmcCGyQs9k/cBYjbpkeJweFNfVbdmd75BiAATtuRdMUmAg57XKwX+N4UctYVZS/vcLzqqFS389QfVOlzZXtcYTpBzMWZuaVR8Sa6AF0dHiwjFV8yHHoiknGcnFTi7TA+XG1rmbi9NRwBjvaQbrlmntLV05jee+xEXTGcN7SZXcsUHR3OWSHAS0IXbQEvf8L+50r3oEcs1ImOwEcRNVYyCjOnHivWk44hSfQZpGDXZV9LXGtY696cd/zm2r4eGQgjP/v3MvMvJuxuFw4f+WJgUNjZZ+Gfs2I/MWnoR/PxPEaT+1B2ZibYRL73hi1LpCI4IhnTVJJSgVMsRMGu4Jeww8EuIDCdYDWGNFtMSp/RiWBnhhwSU20x84i+o4YymgAJ3ebMuhRlH5tTyDmC2MulNCmLhwjwpqbx24N1aiE2o5D
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB8431.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wx/Z5gt/lEPWSObkgqf+ehphmq8gU4vlWJaodL7KSh5+94G3E438wRblWzSB?=
 =?us-ascii?Q?8jaqoeyy6dRiJVzqk1SRJs7pbiUTgMiaJK7Tx3nugzUPSKbAsRZjJwz+LTco?=
 =?us-ascii?Q?Oik6ANbwPEvWQ9UUM0A0yKi4OjIBvTDYUR9/0B3zs/DqdoLJ25P0Ktco+QnS?=
 =?us-ascii?Q?DIlK7yjrAIJ5T9EK340rZqvEmj56VNt6kVhjXfjBJD1a71pHOxZg/0vxi1N4?=
 =?us-ascii?Q?rkiETcWuwrGNNlAflSLXZutowsjs9hb9fu9QpXLETiR1xvHTJwYD8edh8sjq?=
 =?us-ascii?Q?224NXOCkXJtOlfL6DRZa7hVbBEgNoz0vh//UOc2oYRhf4t9iA24oX5v8yf8S?=
 =?us-ascii?Q?PCtPleyrH5Z79yYb0250oUE3JabALAFaxUNlxTGO7NwlCblj95jS1SGrkagz?=
 =?us-ascii?Q?BMBl8leXqEVX0AOKhrHlnDLMHhjW6z7GbtyXHH3MkvBJwpTrpQnDP8kqnygF?=
 =?us-ascii?Q?aYHnAhY1NsraaG+Pbq2rr7ACXYk03LcyrEQvVfTwaRGaW3zkDUEsG/urpqLp?=
 =?us-ascii?Q?TsZoPZlLpbukgS+CBt6tBTKlUHfwoZROsuAPewH/qWMBh98SEL1L6zsqg6mg?=
 =?us-ascii?Q?X+VkF0pySh9/dXkdCzlJM/0jYeSK6hzUZV1vqq2pyERcvvg1xR4cnjbKOKqx?=
 =?us-ascii?Q?zYFM6gX4mOSeL5GesNjHSwi1XJR322KBo0Vg2KQvfa5opBiOxWfzOJzWxJ+m?=
 =?us-ascii?Q?4AHb9vbQtyOWsdKqZOzsyuhs+XYiHJnAd0GuhE29H/E8cDt56dJTQw13knwW?=
 =?us-ascii?Q?yh/t6n5sPW6Uh9Rxulf160fFlnuft6AP3/GpSqfL9QiZol/5Ta/CzwN2RDNG?=
 =?us-ascii?Q?LqvH+z+pUZXhdQ7AHMzw4ej8V5BBW5KYhsOENCzkO/qgHusWNRPbWl9LD7FB?=
 =?us-ascii?Q?58r44XPFWGwIYX42wRWpcfuwJScg/uCx2MQ3bzRxrnXcZSdZnlsfuiE4IIyn?=
 =?us-ascii?Q?A3rqJpjHmLWmhuX6dE5ZI3Ax+J4orJXvPH82Bwm6+kahCghPZRZCryCjHcWw?=
 =?us-ascii?Q?Kgzap22SYEnp0CCSkK6FgbnifJo/7n6I52bZ3uAkg3+6nlkoG/0D08lBRPBY?=
 =?us-ascii?Q?SCJ9nnpJZkROrIBNWap+WBBntI22XQdzP3Xp6hVMOf4v71mOYHq2JrnT+wbr?=
 =?us-ascii?Q?haWGEEQCaJuhDRmNLlgCIHDrXFJYSYMJtcbX4fVhf2yclFEBXhovamwawunP?=
 =?us-ascii?Q?A3OIFwwO0xD21gI/cWztUnPGYuwti3KV9JCNDgbu7WUAw3shtJXqp86l1DOr?=
 =?us-ascii?Q?KTnjebHoMoxGxXsDoEm+3eVl8miD+4HTjeUD9j/QR0XbYZcDT0DQhW6c5T2z?=
 =?us-ascii?Q?h0oBKOBn2WQMPq2I01R+PwEQJTmDxFyK+7Vn/qCIbhINsQ1IjBRkTFwlc9pr?=
 =?us-ascii?Q?hZwgqidJEYdFU5C/q+yV+i3M2h+aaHjrYcPAMyQdqPKgmHmZuzFuTiKCm4i/?=
 =?us-ascii?Q?EIBglBUCPBgQ/utnI7Y5xHRDdar6dLVuOouqKt1wJxc8PW8W19leHWMaVW2/?=
 =?us-ascii?Q?yG+jOyPgeKtKulahpMOGnvjTp6k5TiryFstDjKQVLoTMfFXEVPKGl/tHNsRR?=
 =?us-ascii?Q?bhzpcn6K2awAPGKqB73Up/+nEqJcTrfqe9Wf7p+IVGSDA83aswWn20f7S6As?=
 =?us-ascii?Q?tj/TjvXtzB1gsvtpoDLP1wmhTI94JJXMR9vMsaNwP7Q/5MGaNGYIbCcJYBJx?=
 =?us-ascii?Q?1uKN+fRl8wu01VEIJAAYbnMjr8a6zl1J7ttnug7Jfu5TrSshit9g1p2bvB5t?=
 =?us-ascii?Q?su44cJQ/lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B8AC616150808408665ED3086852C99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB8431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0103ca96-4559-4fc7-51d5-08dea6ee13cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 19:24:19.7547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSjBcOhI/iByZYoawnJc6GXTfbI8wZHQMa1g+WSnn4VCbc200ZHMSV0ei6EElXjrJcO5CTtTzMtrAWNB5O7tDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481


> On Apr 29, 2026, at 02:27, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> On Wed, 29 Apr 2026 at 01:30, Matthew R. Ochs <mochs@nvidia.com> wrote:
>=20
>> The larger buffer is also currently supplied as a kvec output argument.
>> For virtiofs, kvec arguments are copied through req->argbuf, which is
>> allocated with kmalloc(..., GFP_ATOMIC). A large readdir buffer can
>> therefore require a multi-megabyte contiguous atomic allocation and fail
>> with -ENOMEM.
>=20
> Shouldn't this be max_read?  Here "read" and "write" refer to
> direction of I/O on the filesystem, not on the fuse device (see
> fuse/file.c)

Thanks, the read/write direction point makes sense.

I tested changing the cap to fc->max_read only, but that reproduces the
original virtiofs failure on the 4K-host/64K-guest setup. The runtime
values for the failing READDIR are:

PAGE_SIZE=3D65536
fc->max_pages=3D124
fc->max_read=3D4294967295
fc->max_write=3D1048576
max_bufsize=3D8126464
nr_pages=3D124

So for this virtiofs mount, fc->max_read is effectively unlimited, while
virtiofsd advertises its 1 MiB MAX_BUFFER_SIZE through max_write and
rejects READDIR sizes above that limit.

Do you prefer handling this locally in fuse_readdir_uncached(), for
example by capping the request with all available limits:

min3_t(size_t, fc->max_pages << PAGE_SHIFT, fc->max_read, fc->max_write)

Or should virtiofs/FUSE instead make fc->max_read reflect this byte-sized
buffer limit before readdir uses it?

I will address the other cleanup comments in v3: drop the cast, keep the
clamp-style sizing, use release_pages(), and remove the nomem double jump.


-matt
