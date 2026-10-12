Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4043CE73;
	Mon, 12 Oct 2026 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791089; cv=none; b=R3YNG+uzDr1F6a+m/wnljFIlJFfYD9SCyCljQEZnKVMgGWOM19DpNQmWslOg5mbwFYzIcQnHIpbKtB1YRQMZEcKQO1q9kCp711Q0fweSMS5Z6qb9K5MUWaeAsaYVs4D7D8fJSuMlLKSSYInORZaPMkLbnJUd/ClrYRedJ0x5Xao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791089; c=relaxed/simple;
	bh=+CPN7mWucR852/9mCYfD5ng5YGRyRwHev8S7Pk6f6jU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4SXktLpb6RkATGRoWh7tA0P2wu70q/lcNl/EASBQ8j1pD6F0SyZeA5wx0+pYxfda6hphijOZSRuDpHJgFtROG4aov42ArUc5V6DLgXFyRn/QIEsd8RtuRj4YLm2wFMQVf55fJsya+MGtOoD9NfsAJy0hJ30q81GAoBpvYMJzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aoBG+BY/; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aoBG+BY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791791081; bh=F4PefBMi3MdUiym2Gk1xG0A6+VB6Kxbm5CcCuzARj0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aoBG+BY/I6Ak4a1+yEjf5Hli3gZCC4pIhpZrMO+vHm5DlCXNsixQSAG5HnWU7p8KI
	 FSSKGvfdFgdTjwFOIe84c7EOZM0lplZVT9H+1+GU+V3htfoL5TdYBJ+0cOrixYQK0H
	 o6bqG5V6SQou2x8De23zBbLw10MdYggJk6C3tdR8=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B2728EF6; Mon, 12 Oct 2026 15:44:39 +0800
X-QQ-mid: xmsmtpt1791791079tv1bcxc4n
Message-ID: <tencent_463A9FACA88DD4806FE391162761D3B42807@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTkUO6F+hivjj6AVqZOtbbg+Ehv8IVbuue1ACe/4fL9RQjZsIPNqu
	 p+rvCyE5sjrFtmCqefBEyN30nsQ3ExrAvVj1J3DH2R6Q9ps6jji/bk9mr48QRqMQzUHnviddmefO
	 21GQ1erhdAyUDmbJeqco0rlRGQKjJobxrFmrS3iNyjMrmEoZGAld8HGIummAUVs/655ZlPjs6Z+5
	 3XD4rFm057fQh0LX0blp1kTWzGqg//UBHg2GVReqgsUN5+76RaHHQkKJWAHKerg7z/p4NcCppRj1
	 MDQRaLfLJTAeLXCTClUOGgDVBLmOAJjF+NKASQllXYfelU+f2OtUszunmIWRCRuGM2qK9+GhCTo0
	 FOiaMWn39wVlfFbckpqlHibj3AShM4gMAyvZba2qnwnqSnNofIiD6gw7usdpimsaIbnPCwQWTPDK
	 8pH/pg8WXDZJAtZmlwfdglJ4QJpoU4f7AFPu/q3smr/51QitJNkpZmcDPzY72GpTXQee9l6Hzydm
	 yubo5vxJ5HPH4SxCBLKZKUGtMBKZKcg3bqXm6FABLd1rxNWqZBceBumxdVnb62kLBEVro16Ygx4V
	 5VPLyvdOD1pl+s3FWfWVZNRCJiaZVaFI42eSwHrrhAE4M5P8aMM6uPEa4nbFHRT9cxn921k1qdPP
	 aU0lXSwtFPBTS01MU+9Qm3U6o2VrYzdemvNgJ3cqTD5OV0kupbnbNQqo+HtOx58PefnjeCpvrBuN
	 S1y/oetI5sgR5N2cKAwr7PhW8mIy1jwY32WYDdMWO3MouWvoNP1MUTN1vaw1Wd7PUjmr/LAW4g5U
	 vQASqTZ0hzJ+k7pyS7MaArC1MzOvLSBLJNaMKPAHubBPA6aow48ilp6vD4f9Ik2wIMo69FENPVUj
	 UHEpOW5FuNWc7pxlXjw5X0VMXMQchsHyZBbKkXYFubKR9ea0l1tSOkGnAib5nvsIjLF0V0yTKft9
	 omJGTQNp2gAmY0oya9/nt2TBhvlk/CwlsBpQwwh1znai1DessnLq11LApJ6ggVvLt24VSDZDF+B6
	 JxYhQpce2tlw7uwQZLy/b81Fmslx8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: 1sh1ro <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hfs: keep the internal B-tree inodes out of the VFS open path
Date: Mon, 12 Oct 2026 15:44:38 +0800
X-OQ-MSGID: <20261012154438.6396-1-yangguikun19@qq.com>
In-Reply-To: <fb6a6e2ff419fc197c793d9a98fccd2d1332e49d.camel@dubeyko.com>
References: <fb6a6e2ff419fc197c793d9a98fccd2d1332e49d.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Viacheslav,

v2, following your suggestion.  hfs_btree_open() no longer patches i_mode
up by hand: there is now an hfs_system_iget()/hfs_system_read_inode()
pair, the HFS counterpart of hfsplus_iget()/hfsplus_system_read_inode().
The B-tree inodes are created through the generic inode-cache path and
get their S_IFREG there, and the extent-record validation still runs
before hfs_btree_open() succeeds.

hfs_iget() itself is keyed on a catalog record (key + rec) and the
B-tree inodes have no catalog record, so hfs_system_iget() is a sibling
entry point sharing the same inode-cache path.  Folding it into
hfs_iget() is a small change if you prefer that shape.

Patch 2 keeps the alias guard from v1 - a catalog record must not address
CNID 3/4 - as hardening on top of patch 1.  Drop it if you consider
hfs_is_valid_cnid()'s acceptance of HFS_CDR_FIL records for those CNIDs
intentional.

The series applies to v7.3-rc5 and fs/hfs builds clean with clang.

Thanks,
1sh1ro

1sh1ro (2):
  hfs: create the internal B-tree inodes through the generic iget path
  hfs: refuse catalog records that address the reserved B-tree CNIDs

 fs/hfs/btree.c  |  25 +++++--------------------
 fs/hfs/hfs_fs.h |   1 +
 fs/hfs/inode.c  |  85 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 20 deletions(-)

