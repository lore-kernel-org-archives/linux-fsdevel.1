Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8537C10A;
	Tue, 26 May 2026 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803361; cv=none; b=ON1FhGWAjuoIN472WH5FkSIBPEOPMNosmnpIMqIF53fHj4oAAFPYxHO3MRZN34/+x8Kv9+tash0NLWCfYqJmTKR0IdOOS8a3T0xEr/SWD79J3Ln/cJgSewnRzl/p6cD+YLG/RIT5gFLuFWAdpLBeJ0UX3zXD0h95Nd8oR5HN4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803361; c=relaxed/simple;
	bh=Vb8fabjpS1kE3FiNACS91MEL5I0hg6zzFtMbtnR+PEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NLxA3OwrSIrKlOi0rK5Vo8Kcgrk2yV7FIi8Zw1Xp19/9oqzQubP509sUcvGBoEBhZVJUEGRolIXc9KiOAvs2q9Q0eoqGJv19Q80Qm5YgdC0cxEqVadUM1qLgHdO1aMBzoDMUkJw2Ty3xRqbwxGssSYs/sILFoWP++9gBZvDy2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=jIBoZdwz; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="jIBoZdwz"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B14A81D3B;
	Tue, 26 May 2026 13:49:20 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=jIBoZdwz;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D60101E07;
	Tue, 26 May 2026 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779803357;
	bh=1xJNC0w7UPYcmpTmuOTqugCSmGYx253sjO62AYu9cYI=;
	h=From:To:CC:Subject:Date;
	b=jIBoZdwzgo6jjQeAC6d+b9vSyH/nGId4Di31v5Qj4bqYurQ2Xi1RQfP+hk0tNSEhn
	 pHe1iXCAgqhKN09GlFbf9k1GFF90S9S+EXQGhVlRcLlXRzpZHWajpEso2tDgH/EJRZ
	 M5j5RjTblhCMBOe5PDrBe5chtMLH4Y8UkS/HEzIo=
Received: from localhost.localdomain (172.30.20.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 May 2026 16:49:16 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 0/6] Bugfix and refactoring 
Date: Tue, 26 May 2026 15:49:01 +0200
Message-ID: <20260526134907.11402-1-almaz.alexandrovich@paragon-software.com>
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

This series contains various fixes and refactoring for ntfs3.
fileattr was added to modify inode flags.
folded a bunch of functions.
wait for direct I/O to complete.

Konstantin Komarov (6):
  fs/ntfs3: add fileattr support
  fs/ntfs3: zero stale pagecache beyond valid data length
  fs/ntfs3: handle delayed allocation overlap in run lookup
  fs/ntfs3: fold resident writeback into writepages loop
  fs/ntfs3: force waiting for direct I/O completion
  fs/ntfs3: fold file size handling into ntfs_set_size()

 fs/ntfs3/attrib.c  |  17 +--
 fs/ntfs3/file.c    | 290 +++++++++++++++++++++++----------------------
 fs/ntfs3/inode.c   |  65 +++++-----
 fs/ntfs3/namei.c   |   4 +
 fs/ntfs3/ntfs_fs.h |   9 ++
 fs/ntfs3/run.c     |  61 +++++++++-
 6 files changed, 256 insertions(+), 190 deletions(-)

-- 
2.43.0

