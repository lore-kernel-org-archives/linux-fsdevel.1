Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104700;
	b=YHaKYDv4fUOaZWcvOCMF1xO13lGLNE89OrJK4u7L30gJv43B5a68eB48+f1dMxx/rSOa
	 h4Pal8aseRYcg/+Ox8811t7kChPB/1DADUtuJ1aY2r6/EffozDozHgpl8GjtGL+uGQ4xB
	 MKMZgNbYpYGdK1Tw9gfYXzpWACNUiDO/YG/iRgk+Z641o4UjkQ3gJ6DzaUN4416jy8cbo
	 sTrxC2z9l9nhqggfhVrf4rw5pp9DRvFjWsQzWxPNUn6JbTpem/QZZdEUK+SZt0kzmQovz
	 YVjE/4LUB2rr8MkMnPpNYzkBEWRnZVV7S5Q7HcOR2COjLtLZcRlnbHIxK4naZZDDEjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104700;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=97EMAsdL4Jomer7NQwTMkp43n/LTrc3EDjvQrj+11NY=;
	b=HJeTmcpkqA+ELvm+aMwcmoReWbtimcyvUVM6ZdVhWmgJT0XPblovMmsGmlIRpDDqmKVo
	 DTlXFtD/3vQ+csx+EPncpMQo+BNUF3bXhkzoaaGxKFjYR3y1R0LQMzyiU2G1dL9YjNl/0
	 /A1nyz6ik708ayx6iaGuxDM6qOb/UYULIj75gpYqqxxguiGmCuNib3xXIYmnbEDcXpiJt
	 g+oNYQIvnDpxWlcaememYHyiQS47mj9IQ9EIXqlSy6ucbyoUOg9bKtqKDL43rBkD9gj0z
	 ZmO1cnf2plbbqeppaGziPW/JWLBVfTGBCOBWLVGuQ5ElEcqOOiZybfjchKTvszDD/jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nezI9hUK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.44
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF40606A320;
	Thu, 19 Nov 2026 16:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF40606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nezI9hUK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtU7+G5Dnt4L5wO4VTfAezQQBncjRz9FYBCjBjn/+t/p4YNI9KCQkPxHnwj6iaTtPxIYQkCcrTBm71AQDX0lAlbWb7lN6nmLuGjTs7cshohUA4btpHgbefoUT2FtAFi5zSDwOP0nu3Xp203t16vXIdJ9uACjafUc3zHxM0NzX0zSIcVk1lOGOF7hxhpseRj/iHpnsxSDypCU4oce8sf+QGf3jI6xZ9IcqaOR0XJN98+pTw83270vSsE+N+CjIB8bNZyOVyJFCReNKRJsEEMEKIXcTHBRe5CylxiVnNfsdq8azU4v7CSdCodFLEowkKNts6l4+pc06y+Gl6wGPAQuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97EMAsdL4Jomer7NQwTMkp43n/LTrc3EDjvQrj+11NY=;
 b=Hnbd/lrHIqeSKPKlxwBmRN5gYts0HVNod5IrlRbeIlPXMqnNmYDm5aWa+hB0rsdtfPOWZjDB4ibKhFDckupJMr/2vM/OC2qIjfmPHMeWf0o253FuEr09gkMZMrwTGDWKqnFmSHqzMuiwcC4SCc0AXeiJDRRIFrq1jAK5D1DcwSagGPpC0YS39MdPwIuJZtLZLEuHfmP1tXVstAZLzcPSPxaVebHhqEsq+BKf0/UwS8vlH4s2MlSRE69LyyoggL4kd/WHpppmeNMnNrpJw945OklCiNSryvR6p7bhrjSPqdohX2cFGY46AAUQyqvvQz1gxxmCEXQIq52I4n8g4eV0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97EMAsdL4Jomer7NQwTMkp43n/LTrc3EDjvQrj+11NY=;
 b=nezI9hUKeHPOE3Ld1pNN3eOzEDrbQYzupszMCgLFnvjH1CsSFOkPBRlBVWRWf8tsqER2ooKc7U2ejbZZihvwVqwX0C4rBeUArYX4VGqT87WeCZDjQ1ajO3H3k5fRyIC3J+pTHdsueuMT6ymYhv5YHPaDeAl4qeTQHKIu3aNm6H/evDbwHcGMrcO5vR5DEDQutlYKcS7Con2OcJKRBdaFvyTZX0VF86rlZifyz+EVYOJS0Kfz7f7CyqbSFMcaVMJXeg2izrGRSpm2DzNxXyTI76deKIjYQRUEewEwKEmD8XcVTb8LWer65GfUBrklFT0Q/RNHy37EPGsWCODVeiBrKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:11:25 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:11:25 +0000
Date: Thu, 19 Nov 2026 17:11:18 +0100
From: Andrea Righi <arighi@nvidia.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Quan Liu <qualiu@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	Seth Forshee <sforshee@nvidia.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] pipe: Prefer mempolicy node for metadata allocations
Message-ID: <av8fpvUJlUL3BlQI@gpd4>
References: <20261110065219.894219-1-arighi@nvidia.com>
 <hbkxlhc5y2jkvuov5o2kjgpisx2pavuo3ad4c4ydixeic7vaq6@mpzzfmhjvtof>
 <avQP1aXhe7nQuzt9@gpd4>
 <179510365141.412063.5548407366346393690.b4-reply@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179510365141.412063.5548407366346393690.b4-reply@b4>
X-ClientProxiedBy: MI1PEPF00000D59.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::489) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: f286160a-1c3b-453c-2d8b-08df4657c2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|4143699003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003|261028144727099003|261021123027099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	vht7kCKRDU77RwEMqcZNmunnBAtKFv0vz+ZarfAZP9MAFk5Pzcu9UVYQzgYgrdRz00QUnKtsBGrQjCwfQrJ7dJB5GPGNePgEj83EHk76czb4+beIkjEg/LxhqsELAHAm6CsPcFb7hIRuAQzmUSgB6HWQ55NvmZQAwj4OXBTuCIU32GWKmBFP/G8qeoF6NvB9XSFLtMt5jk3YTmpBXVuWbnaF4RrYU3xHe7gqOsIiWtyXKChNDI9VKeOttLNY8GOfA96VCkcxuWR5HD00VmSvoGEGmqZsFz2FfDikJeEDwhCUoJuZiGepuEo5/1oevsScRlV0wJysQndlfcoz5HO5P3QCPY6qZ0y3rzukLfLMrQ3ChlPyOq37rGizvW0xUBO87hvZrkWkoYGuoNKN6kkc0D2f/PPa1ZqqLmVQmi/KAZsiR8rSv1+5HSP/mR5iNTd4exT5EYoTKvp7E6dLjuM/Vvl/E+vXMjlaiX/Ln3KMLFkXG3cq/nvezDoEGepenfjZ9Fq92gDH/QY8pH+ozoD53dEDzuV1zOMSukHsoNxVGwS2A/T9Y1i9zWH017t/gUuJpNSJvjCmpf2Ug3kAWivIQ0/9qWnWOFVkVeuNGvvKudVwk1pi/fBdWWFfHZtIuMq2VFTbKrFOGEDkhUKHIK9yKvl10utADfcFITWyUF/UQTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261028144727099003)(261021123027099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gW3SGqBTbaUO+MQ5zS73R/J7ATNSBZjNqOkfiCTMPABD/BnkchzlPk+ElvtK?=
 =?us-ascii?Q?tDKJnpGh0XFhMtf6ooM48EUIK8psVSxEiIqyx8+nLKgFMC5lEQdhg/XtAHNw?=
 =?us-ascii?Q?WIcM/fDwznQR1tWqEEuoR8vosCiQl36e/GG2VBUMmijiVkTlfhZTRK3KXhK2?=
 =?us-ascii?Q?LxbgwiVYPCTWV5HAyIZs1SIoeLC5ndj3cNWmWNH5bx5fgLdCJ7is7Bx/7a49?=
 =?us-ascii?Q?AQ/4liEPCJQw9H6nmM1tCwV4r4ut6oz98hubizKwgQpvLTrCGm9cpxu9hk7g?=
 =?us-ascii?Q?pHnNZvRCiHkrcS9FowlKKDqftShaVrKXKZJYc+Uhl+XfA6TYPA/1XZ7FwEbt?=
 =?us-ascii?Q?zHEzXXd0cGihlSaRpobS2RTUY8hRqP5H9m4Qvs72tW28Dkg3dh+sTi4nlEvq?=
 =?us-ascii?Q?Er4CBvrf/Tfx7+KLgLXhjXCdZc2GwrepXUxt2jHtrMK9LXECdQpjJ246OZrO?=
 =?us-ascii?Q?ICRWLgonAss2u5bt6plOsgkleDicrpQK4o+PZpHlYcDNNqZY2XlpH7jt96kj?=
 =?us-ascii?Q?22pxRpuzNyWLvrH7xYn0jlF7tc/WTAZ3SFlwkP087fFNjvEF7Wpetkcs6cQ9?=
 =?us-ascii?Q?XQRdJtyndPx1Fh3Lhr5lGXqohBq7PE/E9WB9XfePeGrJwAGbkk8ewjnMSozR?=
 =?us-ascii?Q?SjMyomMsTBa0mt7HrhRs0ud5cmZ/9sXccKnXUp0+hdqscXTtpOd4WdSagA8W?=
 =?us-ascii?Q?1Q3vpWsiBhHjpSieNdxc9dqvS4sPJNNT05mzA22kgSRjlXwfEw9JVaczlEiL?=
 =?us-ascii?Q?SptGlITwCzYCV1//Rx6k6cRvEDjx52QiM4yX9JBPprluuEi5VWKQmmtbaqzA?=
 =?us-ascii?Q?XdCmJU2KkhmxXisV2wIGbVL6ZyCXVWGCzUFyJWSIj3rVP7mBSyOMI+96LuyA?=
 =?us-ascii?Q?2hARf3zl65e6V4fJHYCklneNu9mtQOOHSyCy2sS02eYBls4Oqn+H1sgjHHcB?=
 =?us-ascii?Q?+5/8EkVm1MQgKWbrnTZaM6xbRsUAlttgZfSv83eykivSWMg//qgKehV90NKQ?=
 =?us-ascii?Q?KJ2daorehu/SkDicXG0C79scF3z3jgtff+Tccl2eS9/tHQpOKGOJlIFndWha?=
 =?us-ascii?Q?73vEWUXqxrb58U+BBK9B+VqEGRGIPpMFpQDPmS1ur8nmLxLmZB18ironF1bu?=
 =?us-ascii?Q?PWe4rGql/SKqtJyVt8+XAdJwkNuPQoWCI2qf2nDH6x4L4vb7fLIkcwi6aMiX?=
 =?us-ascii?Q?C2yrNW0lNb5Tkk9+Jq7OAXhZXfuVSa8RW7DDCZr2NQqgar9BdG+DbW/u39io?=
 =?us-ascii?Q?2F9IP/TngBPkoulPUNw0WK7gsx7KIOehFCHXSsbykau1Gkm9rt4SY6HS4dWn?=
 =?us-ascii?Q?iVrloR/qrlvRsdlbCfJ0bqwB/vAgiKQ9+Z/0EAxfiSmF/6QFXXO7zA+Tk1G9?=
 =?us-ascii?Q?LWljsjoHx8hMexpfAJ2py4kRxEP4neKHW3JTs6Za+CWWX7aTJiwBWAQ9oJ+G?=
 =?us-ascii?Q?eEakeeHdY2HKfVlIZEq72iLVlSM+4/2hvMpvwTUHX/FxcnXFmo1AgUj/2dlr?=
 =?us-ascii?Q?+Pex42/IgWICINBYpplmKfzMNrVRT0FgRmd89BZoYLeXEhzIlXnHYTN8k0Fi?=
 =?us-ascii?Q?r+xYzN7lZvhQ4vwgQfLeH7jRW+Btsnu3hUncGmKuzHKSaKejE/kokbqRV8CK?=
 =?us-ascii?Q?Irdo81Qlmv1pvoMOlVWvtYJn9P5RDNW2N+Gn08dDb5dTbPT+x5n9TXqQ+IT/?=
 =?us-ascii?Q?SVTMzoACE8yda5ye+yCqiX87vTsb/zivFw48AlPbjJFilt7B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f286160a-1c3b-453c-2d8b-08df4657c2a0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:11:25.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMpoyZ4C3FIyqjUJhTG+dd2ogbYflpH8bMgQ3ZAvAHFmkQHnUDY2rprPkH3wXVX+kv/cIT6LWjq1IhJHKIJwxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

Hi Gregory,

On Thu, Nov 19, 2026 at 10:54:11AM -0500, Gregory Price (Meta) wrote:
> On 2026-11-11 07:48 +0100, Andrea Righi wrote:
> > 
> > Vlastimil, Gregory, do you think this SLUB locality and mempolicy
> > aspects makes sense here? In particular, does preferring the policy node
> > for slab-sized pipe metadata, while retaining the policy-aware path for
> > larger arrays, look reasonable?
> > 
> 
> Funny enough I was leaning toward task mempolicy being ignored for
> non-__GFP_ACCOUNT allocations but SLAB_ACCOUNT makes this a bit
> complicated.  This would be another scenario I have to consider.
> 
> (related but not directly problematic with the change here)
> https://lore.kernel.org/all/20260701222112.2820098-1-gourry@gourry.net/

Thanks for looking at this, and sorry, I just noticed your email right
after sending a v2
(https://lore.kernel.org/r/20261119160430.1113397-1-arighi@nvidia.com/).

This new version doesn't change where new slabs are allocated: it only
stops the remote partial scan from returning objects outside the
MPOL_BIND nodemask, in the cases where new slabs would be allocated
within it anyway.

I think it should be compatible with your series: the nodemask is used
only when the page allocator would also apply the policy to new slabs,
so the same filter for unaccounted allocations can be added there.

> 
> As a rule I generally think depending on userland mempolicy
> to direct kernel memory placement is fragile and unreliable,
> but your results are interesting.
> 
> General notes - I dislike direct current->mempolicy access in
> random places in MM, and dislike any MPOL mode checking outside
> mempolicy.c - but sometimes it's necessary.

Agreed, in v2 all the mempolicy logic is in a new helper in mempolicy.c
(mempolicy_slab_nodemask()), SLUB only gets a nodemask from it.

> 
> I'm not against slab having better numa awareness, it makes sense
> you'd want to prefer the metadata to live close as well.
> 
> Give me a bit more time to wrap my head around this, sorry for the
> delayed reply, things have been a bit chaotic this past month.

No problem! Take your time.

Thanks,
-Andrea
