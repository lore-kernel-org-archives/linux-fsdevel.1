Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50030382373;
	Fri,  9 Oct 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566243; cv=none; b=tMtaHdCcIqRAbqGiQrCm17F/o5ATWdMtrt5T34FRexkLMC0R8tHXp8OA99C9YDIb5pSbCrjzsB4esDLogMHoLcfPmGwfyTNOwyntow7N9YUB+YqUD92AJoRlzMVAu6l3WpJ5rh2P/KzzBfQfak/oSx0TYjddrLgD22Pf2NPOSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566243; c=relaxed/simple;
	bh=NMoMOHYOtcEzx5ODGTj2gAhe0sCGNVkaNa3cfi1fylk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lORfJxO3VEdzfB5nlK2RRCjB7LgCWBSgDnvoAPAUuFic6CWiW0IY8igZdKQe4MANUKcVyru46QXZy/zLA/L3Az/HaSr93FIBHLl+bswj6xnon6h8VMugNS5UBYjYAm4VZG4pJKH8gKXPGYYwXHRy+qG9VojAlqfe0xia9yMvV2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Y1X4d5dw; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Y1X4d5dw"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 65A291D60;
	Fri,  9 Oct 2026 17:18:06 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=Y1X4d5dw;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 24D4821AD;
	Fri,  9 Oct 2026 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566235;
	bh=xVGzAZ0v3UzxN9m4vLiF/7o7n82CZ2kvmD5rPe1n5gY=;
	h=From:To:CC:Subject:Date;
	b=Y1X4d5dwzA8ubsVRk6HyxH9aGQrw7yBFhSQCSpdRDCGufkcByYp5/RM8Uf/LfLa+A
	 +QVs3Hy6tH9jO1k46zbOSiJveJ1b9HNe/HpkXfMNqbxtqeu5ClrrKASPK+Vb4KpiTP
	 qu9b/stmlu1XwKtdz0ygdNc39atKOtUzXOOpv+to=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:13 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 00/11] Bugfix and refactoring
Date: Fri, 9 Oct 2026 19:16:53 +0200
Message-ID: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

This series collects fixes and cleanups that accumulated in the ntfs3 tree.

The main fix is 11: attr_allocate_frame() kept using a stale attr_b after 
ni_insert_nonresident() moved the base attribute to another MFT record. 
Patches 02, 05, 07 and 08 fix cluster allocation and sparse file size 
handling, and 10 rejects unaligned hole punching on compressed attributes.

Patch 06 adds a 'ugm' mount option controlling whether uid/gid/mode
are stored in the WSL extended attributes on creation. The rest are 
cleanups.

Konstantin Komarov (11):
  fs/ntfs3: show supported options when an unknown one is given
  fs/ntfs3: zero newly allocated clusters when the request is smaller
    than the frame
  fs/ntfs3: drop unused new_size argument from attr_make_nonresident()
  fs/ntfs3: minor code cleanups
  fs/ntfs3: do not force allocation for IOMAP_ZERO on a partial cluster
  fs/ntfs3: add 'ugm' mount option to control storing uid/gid/mode in
    xattrs
  fs/ntfs3: allow a zero cluster count for resident attributes
  fs/ntfs3: reserve a compression unit in maxbytes_sparse
  fs/ntfs3: take ni_lock() once in ntfs_readdir()
  fs/ntfs3: reject unaligned hole punching on compressed files
  fs/ntfs3: fix stale attr_b in attr_allocate_frame()

 fs/ntfs3/attrib.c  | 130 ++++++++++++++++++++++++---------------------
 fs/ntfs3/dir.c     |  38 ++++++-------
 fs/ntfs3/frecord.c |   5 +-
 fs/ntfs3/inode.c   |  18 +++----
 fs/ntfs3/namei.c   |   6 +--
 fs/ntfs3/ntfs_fs.h |   5 +-
 fs/ntfs3/super.c   |  31 ++++++++++-
 fs/ntfs3/xattr.c   |   7 +++
 8 files changed, 139 insertions(+), 101 deletions(-)

-- 
2.43.0

