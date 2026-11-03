Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674406;
	b=2RvDZtyfOEf9h5PuZYnNKR9xlZqyb42E9fig5cIk4DSbc6/m7yGAt94bJes+eQmhbtem
	 qm01uIKqQsOvdK5UluLJpgC1OabnDiwEagHq5xJXmuA7JSC93u7oJlUO/bWlT92HZEZFa
	 c4ndL2n2Z7v/RzGJ+hyiAhvFH5fiHdb7/+GlSvsozWwOmMcgjyPqh+TKJB/E+Zfze5QKP
	 zNYEC1MkzduT7v6qHug39Qjsqtm9ob7/SUqXUPcz12M+usyOzNJvRNMZX5CmC3jP3rJuG
	 PRbhS/b1GFiVPURhHuq96AvRPXphofJvR8bgdzZNj2nysbgYvC/mlZ/eUT3jRfbzaCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674406;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sU/GcVPlW21T35kJzeaSNLA7JSbtg+ZsWk7Dtu8zbgc=;
	b=s5z/R7iZQSN6Zg6tE6ZZH+QoJaiHhnkrh8a2+s6ucSgr/zUgOJ1GESC+MrU1l7tKaSir
	 i3f5tdVkd0F6FumHVJapM7psnJ7QDbpxE2k+apSQJRWecdnwT2khqb0cH2pf/DtHzeOIt
	 UAM6Erfur46f//sBeTvcPAY0a4pn7WfMoaG7h3IwlT1SYVchkedzg3gfcGnHU+8kX3owH
	 cTYhcEL/P1/RDTkkG+kTtX59291SRElFZBLOVjYwjgP2SeefSWrektPvjY5aNt1n1Ywyz
	 RbtvqaZphbMfyLXu1FR/cwssLJum0JsxRJGctwFgoqlyJ1vnWl4Hp0edw4Hf8r24Z3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1P9hjvsg;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7D606A324;
	Tue,  3 Nov 2026 02:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A7D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1P9hjvsg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sU/GcVPlW21T35kJzeaSNLA7JSbtg+ZsWk7Dtu8zbgc=; b=1P9hjvsgrTat8MFhh2NwP5S/Q5
	ByySuesphYtqI535SSzcmC6A95JPJeXLE5aqBKtg8axbzisNx8Pn1x8Tl6oxz80B4uKu7RWOFCRa8
	4MlZbA0Sa1S1AxnbCEKbQdgrLfN2eRXZRmitiyLrSJvVEU49tIhPNika7yd8vnyrAtobwxSAryTmB
	X2YamLNDwaRN4RVHphPTIG9t0mwgvc3yc5lde2hT3nMco/dpcaxWJSy4aVPmO3tOx9u5dsHZOetD7
	BUZKUo+C7H+4c4+bpnEus8+3HPzkZ9CGQ26iYpKoF96/JlFBbFmVCUYQqgvIYBdmpTLLwXiGYS3JY
	8DgV4Yog==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO4eJ-00000000u56-2CVo;
	Tue, 03 Nov 2026 02:53:23 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] fs: porting.rst: use literal string to avoid warning
Date: Mon,  2 Nov 2026 18:53:22 -0800
Message-ID: <20261103025322.2549225-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid the docutils warning:

Documentation/filesystems/porting.rst:1417: WARNING: Inline emphasis start-string without end-string. [docutils]

by quoting the const pointer in literal quotation marks.
(Adding a space between the '*' and the '.' also works but it looks odd.)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609231806.ILZP6Fy0-lkp@intel.com/
Fixes: 025756ee7b47 ("fs: port mnt_idmap() and file_mnt_idmap() to const mnt_idmap")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
v2: add Rev-by: from Jan;
    rebase & resend

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>

 Documentation/filesystems/porting.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20261102.orig/Documentation/filesystems/porting.rst
+++ linux-next-20261102/Documentation/filesystems/porting.rst
@@ -1418,7 +1418,7 @@ All struct mnt_idmap pointers handed to
 ->create(), ->mkdir(), ->mknod(), ->symlink(), ->rename(), ->setattr(),
 ->getattr(), ->permission(), ->tmpfile(), ->get_acl(), ->set_acl() and
 ->fileattr_set() as well as the xattr ->set() handler and the vfs_*()
-helpers take a const struct mnt_idmap *. mnt_idmap() and file_mnt_idmap()
+helpers take a ``const struct mnt_idmap *``. mnt_idmap() and file_mnt_idmap()
 return one. The idmapping is immutable so nothing should have modified it
 anyway. References are taken and dropped via mnt_idmap_get() and
 mnt_idmap_put() as before, both accept a const pointer.
