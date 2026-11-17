Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883481;
	b=B6NxFysnqU49q0fcxok95iqmTZgPzXJKoYd82RrpMgyXn1glYyXmx9UkREW9h0sy5Ck6
	 r480mYys68MIle7CAnrmdAIV1hkTmtQGEfZQh33x2P7/QUR8zIsQ/XH7JvA+6M4xY7KhV
	 hnoihKOjf1Ffc4av5fkx7OF72oUfoxmFILpjDrBW0t6HzpiSkd7hw1Sxb9DrE4Hb1XaiW
	 3pz0ObpwA47c7xsIYETDrOdOnGaJYWzq76UGYYMnvTOi7SKIIQcuwSDYUKm3nCMqzMdX5
	 Moxiu2QEOk1X9uRTeVhJtGuGNJtUdUhozQb2fZ5wm/D65uX3xWabhDPnMhAxfoI0kPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883481;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OsgGTvr772vYOa31xQAPV2HCrq/fmpKBdM5EQit4rQw=;
	b=ZyB0j6bwVXGRSgtoIyryGMmyPOsFWS8LsT1OTpdYsNaA7xg4+F139QLZQFrhgkKUG05U
	 15qBs/9c3KxQAuza8iTk8oFCFmMZEliiT5UAZ6y3KojOcl6vRfhjm6TjsqkbYQgSURs31
	 nNTEiKzNRz84XLKfOcC/7n3zmRRb18PixeDaIhUCg6QQNbLYLouybFKOqKhATVY+S+DB2
	 MKAYNtublRUuCLwkzazgZinouwG+bWutr1rC+q31oMH6GRmT/Dwh8Pmv8gcMgERpsVukf
	 SjLIEP3ko6U/p2XIcpt7UJwQw8tRHNGPoEMzFvMGSfZh66nr+aJWrFTdZFvdrhVgGQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dSDR5Jrp;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F1606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 02:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dSDR5Jrp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794883474; bh=OsgGTvr772vYOa31xQAPV2HCrq/fmpKBdM5EQit4rQw=;
	h=From:To:Cc:Subject:Date;
	b=dSDR5JrpBkexo2Gn8VaIW+mWRh+569X9yjbMO+mwWPh3OJ2WHsTxWXQ1RNE8qbYXf
	 2ebL727JYQXz6irZ5JHbPAVIzr0+STr1rTzEYwHyb1KrhGg8h6Em/6vVuz8FgwJiL1
	 4qK2d6hyNEdgCdhVIiHBJyQ8pglEuJFQszZwyrOo=
Received: from localhost.localdomain ([59.46.81.208])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B202D6C0; Tue, 17 Nov 2026 10:44:32 +0800
X-QQ-mid: xmsmtpt1794883472tfhnw5zkc
Message-ID: <tencent_5587BC2AAF0B8A78412EA72E01CD9C424D05@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/H7p+VHB7d7D/4bIWR6khgBChWde8SWfGNNpNcP4D/+2mIVqYMq
	 jpu9n2IFX5b/u1gTlfeqWviJHQYXdAbWiA88NwJEzKbl8qP/1zNqcjTeZKbMfDWEPYk4OrE+rKVN
	 EP3w/12l5QU23bcVaZts89uJ4O0u4PCT5AdlNRkzb7bic937EbC/V/VRNqTgdQabqpk1/N0u0S/E
	 YYoeZFgZooczaGepZNX+0XYuTuU2iJ2zVy06IKLsPKxKmVoccs9Lt6XvYkN1rl2/x/s1lDiyVafU
	 tWn6HRc+iFyWDPJuvitcUcIzFj+DJ57ptLVBFpgQhGFfmK3vO9Us5GNbwKWn+twaxnNSntkkN74O
	 V/FUagiCTU9/ZpH3cZz3r3LGZwqIEugkaNRX1unyXseUh6ZZwOg3X5Sh7YILqg45Tw6SlAn2QvIl
	 tq0soKUuGheUSbnm5MI0wsMrS8i1no3Phm/vgov8Kt+Gt9QzdntubR/LIZDiG9LV/wHNOcV1376r
	 4iRcW9xMn9GSVcfckjBvaxQdoNt+0XGTbrEJO6yvaCerQlAN9PSE3u/P93Pl0VjUckE5wLfhlPKo
	 5TmjuYzqEoNLjncH5hLbdPKGRXwP9bORAfJaina5Df6z0YUNszwrqm8mxMixT6SjUigIu5tMV7A5
	 ZcK4Up8+/uqSSez0HfCdhNAP6jR/q6qg4kFMilcBcoCEM8VozACKa9D5hxUShi7Ph6L+Kf5KgnOo
	 Tno43ObIt+EGqf0yYow7yAJ+iAHaHpfX9ZVg/BO8TWJxCzo5npwXPT6qowQIy1Z8aLGahN633sJa
	 IVGa+JnyWzICiYHGvxt++V2KgUoydj4cyfxXzyP+lvjJjSCTLot3bsEtc+Y4rfClvqoxuPP8KTnT
	 5+bn/Sjwb1ssIIzAYU994cxvD4cdHung/x1LPzVoEMD/RBPLzMQ7i84OFoxV0GwlaUfnm7thMIij
	 2EOlBybh/iQi4e6q5p5AVG66iTzbUrAtQyTNghZuY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Lei Qiu <750592120@qq.com>
To: slava@dubeyko.com
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] hfs/hfsplus: validate uid and gid mount options
Date: Tue, 17 Nov 2026 10:44:31 +0800
X-OQ-MSGID: <20261117024431.21914-1-750592120@qq.com>
X-Mailer: git-send-email 2.43.0
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

The conversions to the new mount API declare uid and gid as fsparam_u32
but consume result.uid and result.gid. This bypasses make_kuid() and
make_kgid() as well as the validity checks in the old parsers. As a
result, both filesystems accept the invalid ID 4294967295, and IDs
supplied through fsconfig() in a non-initial user namespace are treated
as raw kernel IDs instead of being translated through that namespace.

Use fsparam_uid and fsparam_gid so the shared parser translates the IDs
and rejects invalid or unmapped values before storing the typed result.

Verify both modules with W=1 builds and a before/after QEMU test covering
fsconfig(), legacy mounts, and a filesystem context configured from a
user namespace mapping ID 0 to ID 1000. The fix rejects invalid IDs with
EINVAL and preserves the mapped ownership and valid mount options.

OpenAI Codex assisted with identifying the issue, implementing the fix
and reproducer, and running the validation.

Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
Fixes: 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount api")
Cc: stable@vger.kernel.org
Signed-off-by: Lei Qiu <750592120@qq.com>
---
 fs/hfs/super.c       | 4 ++--
 fs/hfsplus/options.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 5e6d66ff4..4309cc23d 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -203,8 +203,8 @@ enum {
 };
 
 static const struct fs_parameter_spec hfs_param_spec[] = {
-	fsparam_u32	("uid",		opt_uid),
-	fsparam_u32	("gid",		opt_gid),
+	fsparam_uid("uid", opt_uid),
+	fsparam_gid("gid", opt_gid),
 	fsparam_u32oct	("umask",	opt_umask),
 	fsparam_u32oct	("file_umask",	opt_file_umask),
 	fsparam_u32oct	("dir_umask",	opt_dir_umask),
diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index 9b377481f..3ec428142 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -33,8 +33,8 @@ static const struct fs_parameter_spec hfs_param_spec[] = {
 	fsparam_string	("creator",	opt_creator),
 	fsparam_string	("type",	opt_type),
 	fsparam_u32oct	("umask",	opt_umask),
-	fsparam_u32	("uid",		opt_uid),
-	fsparam_u32	("gid",		opt_gid),
+	fsparam_uid("uid", opt_uid),
+	fsparam_gid("gid", opt_gid),
 	fsparam_u32	("part",	opt_part),
 	fsparam_u32	("session",	opt_session),
 	fsparam_string	("nls",		opt_nls),

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

