Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B5413B293
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892343; cv=none; b=VE2F34AhoCNc3MrEgVf3ubL5Th9VNrHbEtiZXJWPNFEwTDI5QgSQ3wxEDg3VAJguwLmc8N7VM3KT+lgr8SspoZ+Bxy7hzII2CbAR9fHdsfFOtldHitcZdov8Vs2veSksEYEgzdYcfPuKTIF+LuTDnMmZqWzCJ8UrUmadh4OsxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892343; c=relaxed/simple;
	bh=aIONqc5J7U7FxokSJR/mE6aRUJM+5HDPr6gd9p0SgJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxvTNlnuvHRnHfjCprNkdtQKYFs1PTxHkcheCVvNZwHRKlfBcR7kYc63SnkWORLGMXWn7jlii66OIyIJazzmmKNvKYOB0q7MiTtGHq9H+viwb4juLIeC+pYXJojGNbz52AZN1PLv1xculSdml58T+rZTMON8Z+lBUYmnETAhYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=2hRWbxYN; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="2hRWbxYN"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a535e7c00so6029787b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773892341; x=1774497141; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aIONqc5J7U7FxokSJR/mE6aRUJM+5HDPr6gd9p0SgJM=;
        b=2hRWbxYN7ezbF1xxeYvkaiZSrihY7fEUOvzKQ5CFlokEfOakWqpELOEgONAj3eevqq
         RlhRTWeW83qgzW9pZKLb6niOuv1G9iehM1BQWN6Gcp29IoyEjWf/tT6Upr4I72zvi5HE
         Ay6agFTFsWUOtNqhOXHLIWfFZeLA11bNb9oMcByNUY2w4FGUk5nuyOt+G45umktE7/dK
         K49iSQPGofFvCAkxPZ0bNQoLoIf0i/cPBKKalKqGngvXTAZvGmFbeyWcwsjMUPcIbyaT
         Kg13LvMoVgrurvI/6bp6TjNUJLKU8xyfz+XhqUzitVIYNvUtXyxMIsNuHL+gtkCnX3dU
         r32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773892341; x=1774497141;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIONqc5J7U7FxokSJR/mE6aRUJM+5HDPr6gd9p0SgJM=;
        b=FFIH05Ou41rXkFm9VARUz7ocjpM7pdH37FO3Gk9qgpNrNRNkvnk66E9y9Xbslf/Opg
         bX9BglQD4CX3TRlHEjhVOT+qBm8DZnRFZAO9vB/aaZAR6/CRwhrtQpDKqzyWQGTwDL3l
         mnIDrS2blJNkSSIaixiQtHbWSC1WtDbDSeVt9aV6FAi0dqPvwexz0jJDQtlfC2YQ1JYk
         CiOXJ31RwQsCGYnWIGpWJ0KPLD0L1YEP7dqwrj0lyPs3aouMGnY/IQCPaekjWOkb3iau
         7zVm56vzL8x3yz9n3C/+sY+BGJ2UXW7UHFsy0Uofc+ybMbc4sAZKvQQPih1PUZZKf14B
         QPLw==
X-Forwarded-Encrypted: i=1; AJvYcCXITAKN0gSBAlVWvcLwomylNLqZKn0rEA5cgX81rQYwPUvsbXbXoX/mbjEeaziP7qyc2L6RJqdWbeddoTW7@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZsJms+Lxq9qD0PkI5yvdWCDNqFmBlGus1s/sGzA93Vnzytet
	MFpR2+HEr+BAsokPBEqm3k4k83hKphVCAJxYukxbnmhozsg9K/Jh103eIbJAggfOtZg=
X-Gm-Gg: ATEYQzxo8KIEnFpcYjpJsvP1Jh3UwTHb4V4vKILij3PmUpK9xQQ8+OJTVNp2NohKo1N
	AuMmu+pIcNiyaRf1LH7BwamZhgLVeoNTjvAVpI7flh1HKjpHqrsp4Lux+yQN11JaoXiOIZRL4UG
	kmjipuN621scvN7ZqGVuQFv/k15yRONAlaNt6Dvcewhi7l9qUyaiZw/f+7GwW4VYrPI4783UTjq
	oYUCm0zyOw9ZxPWDDc0/DAtDYLWUJJm4NguyRP8QYkncVYIKFNNjBQApT+fxxgCS2nZvnRHUC2I
	lwvWTNscUEhsaiFDAZoCBnjpo1dxolkR6V/Jixe0zM3t2/7MtcHFCNg6bQTwRKkQEXkh/qvFo2L
	UUjNaDOVlVAJXip6zlr2O8d3F2BIo2Ny9xPY4xcl7xdYJkxiqSrHrOhm1jJpsKdtcKKhQCM8WUn
	0g3Cg7ayFdPa5RA82OgtLebP2CXS/+F5fC+PFbyen6hi2FVoq0Lhljoe+NzJuvS/CAbZ/sK7rOI
	ouGsDvqVCaErVjkxsrvWgs70x5+4kurykI=
X-Received: by 2002:a05:690c:660e:b0:79a:37c5:5d29 with SMTP id 00721157ae682-79a71db8246mr64063277b3.57.1773892341448;
        Wed, 18 Mar 2026 20:52:21 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:fbb1:1a9c:e8af:d8ed])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a711657b8sm29874797b3.0.2026.03.18.20.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:52:20 -0700 (PDT)
Message-ID: <d78ce2eef08a03523180aadf06cbc7f6dea506fc.camel@dubeyko.com>
Subject: Re: [PATCH v7 0/2] hfsplus: prevent b-tree allocator corruption
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Wed, 18 Mar 2026 20:52:19 -0700
In-Reply-To: <20260318073823.3933718-1-shardul.b@mpiricsoftware.com>
References: <20260318073823.3933718-1-shardul.b@mpiricsoftware.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-18 at 13:08 +0530, Shardul Bankar wrote:
> Hi all,
>=20
> This series addresses a Syzkaller-reported vulnerability where fuzzed
> HFS+ images mark the B-tree Header Node (Node 0) as free in the
> allocation bitmap. This violates a core filesystem invariant and
> leads
> to allocator corruption and kernel panics.
>=20
> To fix this safely and cleanly, the series is split into two parts:
>=20
> Patch 1 introduces a unified, robust API for B-tree map record access
> (struct hfs_bmap_ctx, hfs_bmap_get_map_page, and hfs_bmap_clear_bit)
> and
> refactors the boilerplate page mapping logic out of hfs_bmap_alloc()
> and
> hfs_bmap_free().
> Patch 2 utilizes this new API to perform a mount-time validation of
> Node
> 0 via hfs_bmap_test_bit(), forcing a safe read-only mount if
> structural
> or bit-level corruption is detected.
>=20
> Note on Allocator Optimization: Following discussions in v4,
> there is a recognized opportunity to optimize hfs_bmap_alloc()
> from a first-fit to a next-fit allocator by caching an in-core
> allocation hint (roving pointer). To keep the scope of this series
> strictly aligned with the Syzkaller corruption fix, that
> architectural
> optimization is deferred to a separate, follow-up patchset/thread.
>=20
> v7:
> =C2=A0- Type Safety: Changed the return type of hfs_bmap_test_bit() to
> `bool`,
> =C2=A0=C2=A0 allowing the mount-time validation in hfs_btree_open() to cl=
eanly
> =C2=A0=C2=A0 catch both IO errors and cleared bits in a single evaluation=
.
>=20
> =C2=A0- Overflow Prevention: Added an explicit `(u32)` cast to `off16`
> during
> =C2=A0=C2=A0 page offset calculation to clearly document and prevent 16-b=
it
> integer
> =C2=A0=C2=A0 overflows.
>=20
> =C2=A0- String Accuracy: Updated the CNID string macros to use their
> official
> =C2=A0=C2=A0 structural names ("Extents Overflow File", "Catalog File",
> "Attributes
> =C2=A0=C2=A0 File") per maintainer feedback.
>=20
> =C2=A0- Documentation: Corrected a stale docstring error code (-EALREADY
> to
> =C2=A0=C2=A0 -EINVAL) above hfs_bmap_clear_bit().
>=20
> v6:
> =C2=A0- Symmetric Mapping: Updated hfs_bmap_get_map_page() to return an
> unmapped
> =C2=A0=C2=A0 struct page * instead of a mapped pointer. This ensures the =
caller
> =C2=A0=C2=A0 explicitly handles both kmap_local_page() and kunmap_local()=
,
> preventing
> =C2=A0=C2=A0 dangerous asymmetric mapping lifecycles.
>=20
> =C2=A0- Bisectability: Moved the introduction of hfs_bmap_test_bit() from
> Patch 1
> =C2=A0=C2=A0 to Patch 2 where it is actually consumed, preventing a -Wunu=
sed-
> function
> =C2=A0=C2=A0 compiler warning and keeping the Git history perfectly bisec=
table.
>=20
> =C2=A0- API Clarity: Renamed the bit_idx parameter to node_bit_idx in the
> bit-level
> =C2=A0=C2=A0 helpers to explicitly clarify that the index is strictly rel=
ative
> to the
> =C2=A0=C2=A0 target hfs_bnode's map record, preventing future absolute-in=
dex
> misuse.
>=20
> =C2=A0- Naming & Style: Replaced hardcoded 8s with BITS_PER_BYTE, updated
> local
> =C2=A0=C2=A0 variable names (m to mask, data to bmap inside the new helpe=
rs),
> and added
> =C2=A0=C2=A0 kernel-doc field descriptions to struct hfs_bmap_ctx.
>=20
> =C2=A0- Minimal Diff Scope: Restored the original variable names (data, m=
)
> inside
> =C2=A0=C2=A0 the legacy hfs_bmap_alloc() loop to keep the diff surgically
> focused on the
> =C2=A0=C2=A0 logical changes and preserve git blame history.
>=20
> =C2=A0- Error Codes: Changed the error return in hfs_bmap_clear_bit() fro=
m
> =C2=A0=C2=A0 -EALREADY to -EINVAL.
>=20
> =C2=A0- CNID String Lookup: Replaced the sparse string array with #define
> macros
> =C2=A0=C2=A0 and a standard switch statement for cleaner subsystem visibi=
lity,
> per
> =C2=A0=C2=A0 Slava's preference.
>=20
>=20
> v5:
> =C2=A0- API Encapsulation: Introduced struct hfs_bmap_ctx to cleanly
> bundle
> =C2=A0=C2=A0 offset, length, and page index state instead of passing mult=
iple
> =C2=A0=C2=A0 pointers, addressing reviewer feedback.
>=20
> =C2=A0- Bit-Level Helpers: Added hfs_bmap_test_bit() and
> hfs_bmap_clear_bit()
> =C2=A0=C2=A0 to safely encapsulate mapping/unmapping for single-bit acces=
ses
> =C2=A0=C2=A0 (like the mount-time check and node freeing).
>=20
> =C2=A0- Performance Retention: Retained the page-level mapping approach
> for
> =C2=A0=C2=A0 the linear scan inside hfs_bmap_alloc() to prevent the sever=
e
> =C2=A0=C2=A0 performance regression of mapping/unmapping on a per-byte ba=
sis,
> =C2=A0=C2=A0 while refactoring it to use the new ctx struct.
>=20
> =C2=A0- Hexagon Overflow Fix: Fixed a 0-day Kernel Test Robot warning on
> =C2=A0=C2=A0 architectures with 256KB page sizes by upgrading the offset
> variables
> =C2=A0=C2=A0 in the new struct hfs_bmap_ctx to unsigned int, preventing 1=
6-bit
> shift
> =C2=A0=C2=A0 overflows.
> =C2=A0=C2=A0 Link:
> https://lore.kernel.org/all/202602270310.eBmeD8VX-lkp@intel.com/
>=20
> =C2=A0- Map Record Spanning: Added a byte_offset parameter to the page
> mapper
> =C2=A0=C2=A0 to correctly handle large map records that span across multi=
ple
> 4KB
> =C2=A0=C2=A0 pages.
>=20
> =C2=A0- Loop Mask Revert: Reverted the 0x80 bitmask in the alloc() inner
> loop
> =C2=A0=C2=A0 back to its original state (and dropped the
> HFSPLUS_BTREE_NODE0_BIT
> =C2=A0=C2=A0 macro), as it represents a generic sliding mask, not specifi=
cally
> =C2=A0=C2=A0 Node 0.
>=20
> =C2=A0- String Array Cleanup: Replaced the verbose switch(id) block in th=
e
> =C2=A0=C2=A0 mount validation with a clean static array of constant strin=
gs for
> =C2=A0=C2=A0 the CNID names, per reviewer feedback.
>=20
> v4:
> =C2=A0- Split the changes into a 2-patch series (Refactoring + Bug Fix).
> =C2=A0- Extracted map node traversal into a generic helper
> (hfs_bmap_get_map_page)
> =C2=A0=C2=A0 as per Slava's feedback, replacing manual offset/page manage=
ment.
> =C2=A0- Added node-type validation (HFS_NODE_HEADER vs HFS_NODE_MAP)
> inside the
> =C2=A0=C2=A0 helper to defend against structurally corrupted linkages.
> =C2=A0- Replaced hardcoded values with named macros
> (HFSPLUS_BTREE_NODE0_BIT, etc).
> =C2=A0- Handled invalid map offsets/lengths as corruption, continuing the
> mount
> =C2=A0=C2=A0 as SB_RDONLY instead of failing it completely to preserve da=
ta
> recovery.
>=20
> v3:
> =C2=A0 - Moved validation logic inline into hfs_btree_open() to allow
> =C2=A0=C2=A0=C2=A0 reporting the specific corrupted tree ID.
> =C2=A0 - Replaced custom offset calculations with existing
> hfs_bnode_find()
> =C2=A0=C2=A0=C2=A0 and hfs_brec_lenoff() infrastructure to handle node si=
zes and
> =C2=A0=C2=A0=C2=A0 page boundaries correctly.
> =C2=A0 - Removed temporary 'btree_bitmap_corrupted' superblock flag; setu=
p
> =C2=A0=C2=A0=C2=A0 SB_RDONLY directly upon detection.
> =C2=A0 - Moved logging to hfs_btree_open() to include the specific tree I=
D
> in
> =C2=A0=C2=A0=C2=A0 the warning message
> =C2=A0 - Used explicit bitwise check (&) instead of test_bit() to ensure
> =C2=A0=C2=A0=C2=A0 portability. test_bit() bit-numbering is architecture-=
dependent
> =C2=A0=C2=A0=C2=A0 (e.g., bit 0 vs bit 7 can swap meanings on BE vs LE), =
whereas
> =C2=A0=C2=A0=C2=A0 masking 0x80 consistently targets the MSB required by =
the HFS+
> =C2=A0=C2=A0=C2=A0 on-disk format.
>=20
> v2:
> =C2=A0 - Fix compiler warning about comparing u16 bitmap_off with
> PAGE_SIZE which
> can exceed u16 maximum on some architectures
> =C2=A0 - Cast bitmap_off to unsigned int for the PAGE_SIZE comparison to
> avoid
> tautological constant-out-of-range comparison warning.
> =C2=A0 - Link:
> https://lore.kernel.org/oe-kbuild-all/202601251011.kJUhBF3P-lkp@intel.com=
/
>=20
>=20
> Shardul Bankar (2):
> =C2=A0 hfsplus: refactor b-tree map page access and add node-type
> validation
> =C2=A0 hfsplus: validate b-tree node 0 bitmap at mount time
>=20
> =C2=A0fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 229 +++++++++++++++++++++++++++++------
> --
> =C2=A0include/linux/hfs_common.h |=C2=A0=C2=A0 2 +
> =C2=A02 files changed, 184 insertions(+), 47 deletions(-)


Applied on for-next branch of HFS/HFS+ git tree.

Thanks,
Slava.
