Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793629044;
	b=YGoC+/vzleuDh8bUsxAzYnbSxffjOAH0eH0Wv2aoCv9aidBeNOS4Je/xVrwwu2LqufL1
	 U5KKnCHjCT848e0tVE/iszFQSX3a2LvRl92PdeLDs/LidJaHH8btXcb97btHYVdjLRFuY
	 GOPGIB+1RsJB4wUcMNC+hNHYBftpwv91z2IthbGWnM1xk/0HU0Gwk3oves4OnGpQBS8Kq
	 WbIRfJIZk0EbiQ31NKvD0m76Cl+vZpqT2trhDE5SHPMbNiz2cnl+t1/6ZXflFq3r3S6Py
	 NZBNn/EHQNxsxGlj17Q+oIkbXyJNK5NQDH/duddPENnrFMOAOCGwC22KJ+uIhFLshKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629044;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dwfl2AmuC+M4o/omt7wHLBOy1C+nCPazfhUwmnQKmYc=;
	b=VLEZt11NDYDG58DfreEDeE2dd51/Z52Cw+f5FShX+nt80JaBl9VoYUKobu5S94aq2BWl
	 3FluYt0tNpMfPlIw/Z66bCjyB4tk+axfqVxNKuvLT5kD7IaWQonyPvqUlronJZuk5DiZ9
	 B9zO66zXddjzKpJBT07JK1p2LDNpcwios3lrPFVaDJwpJbWa8mXh4nQ41KbBjjis0/7fS
	 3OhCYjjv/u7DhPLCvdmJPWnas7VqIohug1XhSqkeKecjq2uh5DnE8LQbFybhUiBteNKhJ
	 7wSBf/qP1A0ksm1n+tYGMeLqhIlKGy0eYnuE7BV4o1dnkJWPST7a8M4BbS093Two3HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pinc-software.de;
	spf=pass smtp.mailfrom=pinc-software.de;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OyEldene;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=m3X16Gfs;
	arc=fail smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D8606B5EB;
	Mon,  2 Nov 2026 14:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C36D8606B5EB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pinc-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinc-software.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pinc-software.de header.i=@pinc-software.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OyEldene;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=m3X16Gfs
ARC-Seal: i=1; a=rsa-sha256; t=1793629034; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Oq5d7DnVZcAlDCPBSxEvy7O+PwUKsDIlU8aLQ+bG19MH4Pgmf+STzZn3V9jnyFV7DS
    BdwVBZFbHVxHEVpI0dnwX30e+GrXm8pgGtLfD05TJU0aJJNjS2krmpxQ3MdTbS8NO0NV
    iU1juTOelKP84/OmqLCuJOp1mI6a0c2lG7T65xeXuQuLEKNTgMLfkO/VXwMrlLaMB5BR
    WSgUvO1tgBdQ9MFCihQ+mpyMkSAA8auTmoli6lRp51Ge97ekg2gWs1GLxVgisNl+37QS
    E1dH0OKquyrtSLU9f7r39lRiMPVkLRlWuM/WQoaISUpFZF1EF/+QVk43FtqAFqcjiluc
    dybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793629034;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dwfl2AmuC+M4o/omt7wHLBOy1C+nCPazfhUwmnQKmYc=;
    b=m4co0dVdLeE/tboap1AG8MCn4cEKSEUbE747sdS0mDHetRdy5zp2slPk279btTeK+q
    mzoG0cQbgST6jS37q1Q+b7IMlIMm7DDmr09xoiMDJOBc6FX1VGUSaOU4lScsUy3g5nli
    6ycA9X36xyOd1yLuOgCknXehoq+DOZo0SVdvZhDal/aYH9S0FH9qjFw/+7YHlwT4Kz5h
    tQXCSwcgdExGKMqXpMJYot+AeaaBcqqOVFY0iajpqgyfXKmM6so/Rb2XYCmJ6G9rGozh
    8oCjXOYnjqyxD7iaccZCYVp4NNFdUYH8MVo54bvNt14jl5XLPKB4qoN3frFuc0LOWism
    GXHg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793629034;
    s=strato-dkim-0002; d=pinc-software.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dwfl2AmuC+M4o/omt7wHLBOy1C+nCPazfhUwmnQKmYc=;
    b=OyEldene8DNn5ngTS+E2J3ec6R3uX/5UuZdV9NIJ1OA6Diuy763yV5kgevlL6jxxks
    2JBGL7VMPsjqqxSZQcXSzTHKtZvJ48KRMDEpoyIVjSRc7c+z9VfnySgvKkUEC38P6hn/
    t6R5VY7PsfYeO+gkdishKr7+DXJ1+txzm0zIpDpHirR4D9OXKkr6Soon30IFTxh6C14m
    OMDup7HSCWvfLnfAFd5AqTRkL4NdsEcDTf9DpcZeLqYN20KEwcIngYcZqgek1RaDbNph
    jo1gnf3gLyw5WP0sFHRPOa7uRqDr+lm+383WohLteNQd2vj7BV1i6blAmWWeXBQcm/tb
    D2FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793629034;
    s=strato-dkim-0003; d=pinc-software.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dwfl2AmuC+M4o/omt7wHLBOy1C+nCPazfhUwmnQKmYc=;
    b=m3X16Gfs+Bz8hlAWFn943tgPbaEmdJqOOsvObTnBh9V0XOdn3jansnB1LF/iEOktZ+
    7hzF7eA9GCiQa8yNv7AA==
X-RZG-AUTH: ":LXQBeUSIa/ZoedDIRs9YOPxY4/Y41LMYtYgA+S704E62CSg2BLG6dk+k8/0cpS1xrQjovw=="
Received: from phoenix.fritz.box
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id a2f6e42A2EHEALI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Nov 2026 15:17:14 +0100 (CET)
From: =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
To: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] befs: Allow file sizes beyond 2GiB
Date: Mon,  2 Nov 2026 15:17:12 +0100
Message-ID: <20261102141714.306719-2-axeld@pinc-software.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102141714.306719-1-axeld@pinc-software.de>
References: <20261102141714.306719-1-axeld@pinc-software.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This just enables LFS support in the VFS. The implementation already
supports large files.

Signed-off-by: Axel Dörfler <axeld@pinc-software.de>
---

Notes:
    v2:
    - Rebased onto v7.3; sb_set_blocksize() is now checked for failure, so
      the assignment moved below the new error path.

 fs/befs/linuxvfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index ee0cbae521b9..f715dd71a38c 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -862,6 +862,7 @@ befs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* Set real blocksize of fs */
 	if (!sb_set_blocksize(sb, (ulong) befs_sb->block_size))
 		goto unacquire_priv_sbp;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &befs_sops;
 	sb->s_export_op = &befs_export_operations;
 	sb->s_time_min = 0;
-- 
2.56.0

