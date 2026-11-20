Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795135284;
	b=2+p68cC8+30/ZK96Rw4HLp18DBPW9lQW87JB0QwHnEThr/KmElMaG0L9/TrYAYZAlxTU
	 idpJ1njiCsd8fYLxLaGAFgXe/nIgFsvxa5nefUyBSEjeWea8RYjux0gPW4DhlVtT0Usbv
	 epI9oIJhLDDrOFvaHmm6OQmkFVZ3PzkAtqNXLrdMI2rG8bk1tmSb3KdpzIExdahhFG+qQ
	 N0VyPU8KcThtJvrxXrGPPe3UYqmfsce0jPxu99mDLgIk6iUrliO77cXJiojYz3vGSeQ/q
	 F2prhRnlaQOPndMSt5+33wFQpy+uYtV52qSmvfukADov2o26SzdWsZQfcveJUx2tAUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135284;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fmImNQFnIMk1Bg6W92shHm5q2Pz72r3vJoXlRhep+nM=;
	b=ox06/Orowm9qf4EVC6Cs4TWw+ZN067LIchnPrZgIKQd2PpJTSV7ac5XgTl3YLYn7C71E
	 5Pn/lvEbdpOwZXCFFWK+Aqf7OfbhKi0uNwNLkaJBAwZQ/CfNuy2oJ2LVaBhsoDt7U2xWQ
	 HoGoPmo4Diakt8gGDewynRWHYVtgv8lLBTFe/LRhgBcpJ7tTExtEqL3EqTVwyFgzCLDfh
	 VNsC1ctvBGvIe5spUrMrflI2M0xOWlWkqqLWKvqe50SlsBBwMdDSSf/EBq7SLy/qRf4w6
	 Dts8b5LYqwhp9se3ZTKnvr11N620T0AirQuhFjWdL5/+bv6I5ACyLxbv5SUj0a/ViWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHkCizWD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A15606A320;
	Fri, 20 Nov 2026 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHkCizWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A87F1F000C6;
	Fri, 20 Nov 2026 00:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795135283;
	bh=fmImNQFnIMk1Bg6W92shHm5q2Pz72r3vJoXlRhep+nM=;
	h=From:Date:Subject:To:Cc;
	b=JHkCizWDikTJn2KQkdi8/bEaCSHj0Gp90ptOBd5oozPtYSll9wEsCH/72Pd6gC11u
	 N3SIv5DBGaXmYpuTO+j7YQQWRQ4nUTWKwOwf+Sdhmd6lUDhb00D4Uh+y2p3XCLjK9L
	 bTbhV/LWAq4iw5Zqm97LYAdZLEV+yhoufCG3qiwVrLZzWk5zAV7pqGcRBOnngcZWzi
	 nuEL/6sMQcg57WnYzwNDouLqbQtB5YufVMi/NJUx8X55Biu+2eaWvsn1/GcSdTccFM
	 WGlWhZZo3PSFoWMZNUW5xIL0Ha6dRS9wEy73k06Hm/VLxEdgh29+LLqKo4G+tGYoUF
	 xNmsZNYkw3ILQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 19 Nov 2026 16:41:01 -0800
Subject: [PATCH] fs: use multigrain timestamps only with nanosecond
 granularity
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-mgtime-v1-1-fd28399a5557@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0NL3dz0kszcVN20ZANzgyQjM4uklDQloOKCotS0zAqwQdGxtbUAdPi
 AGVgAAAA=
X-Change-ID: 20261119-mgtime-fc070b268bdf
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=E8azySa7/OzX7Ad9BT+YgzCNxoMcPv6dKqhib1PkV3o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBq/5cuYUapOrya8l0tWk8uWwILqDcFRlFhFEPr5
 sCWDnf6PoCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCav+XLgAKCRAADmhBGVaC
 FYb0EADF5CLy4jAU0xgiyv+CyS9V+XAgGuVp+FuXYU+oKTjJoTqpgALw5gG8TplfjkQnRiK0Nez
 Op6yrAj2hauoM6YEYqa0QKinqP3Ykn8KpSIWVZzZWlc6tvPY/GmUUiju6Rbf5XWXd58YVGcSxW/
 DsiW7dPaYgRA9bRVkarr6DHoMlsKb6oMimcDc/pTNpiGqaVnfZ2UUpxMylkFRMDZ3+ctziJ2+KS
 LsXr5SVa3UVRukTD+iuhtKLiocMz04FAvKe4ksB8YFm2i6wqKhwzzmQudmxnAfaNrIhKT6tw8jm
 N9dDqfgT6c9hJ5GbcJ53IDsuM12eO9oHDYt6sWgnU6gx/9N8pZathay6pIukjDTTHfWJumBa4Gj
 q2nZ7CsgYJCiP3gTHgjnXPtkFC1rWjr0qveBE/UBL7KOCpcgTrmw4wPOOPocMETXQ9YztfaZXWi
 wJY8YAD83TuH7Wfhxqw7YSSqX2h9IMzvo/OoYjvcHLSKK21Kf+bdVhL2dkRTW7gdLj5S5OwsxSA
 KxEbJB0vef02iIccU62iBnHfHx13jpJ4sodwri/vP6zcv1IO1CZ0hD5bJptJd7yVM1GwpL1fPPR
 QHjEweLmDP8hNkJxlyTK3dA+Z2aUWXY5xxJG1IUyN0WBpZZPOq7u9DtmypM6Q+FmW5uG3ASwo9W
 Z7Xp3OjlmVO/hUQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Multigrain timestamps promise that a change after the ctime was
queried shows a later ctime: inode_set_ctime_current() takes a
fine-grained time when the coarse one isn't past the queried value.
But it truncates that time to s_time_gran, and on a superblock with
coarse granularity, such as ext4 with 128-byte inodes (one second),
the truncated fine-grained time is no later than the coarse one, and
the update is skipped. The inode is still flagged IOP_MGTIME, so a
caller relying on is_mgtime() for that promise, such as nfsd deciding
whether it can move the change attribute by moving ctime, is misled,
and the multigrain machinery only costs a fine-grained clock read.

Set IOP_MGTIME only on a superblock whose s_time_gran is 1. Every
FS_MGTIME filesystem (btrfs, ext4, f2fs, tmpfs, xfs) sets s_time_gran
before it allocates an inode; document that it must.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
When I originally did the multigrain timestamp work, I missed the fact
that ext4 can have an s_time_gran of NSEC_PER_SEC. I think this is a
very uncommon setup, so I don't see a need for a huge rush for this one.
Please consider for v7.5.
---
 Documentation/filesystems/multigrain-ts.rst | 6 ++++++
 fs/inode.c                                  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
index c779e47284e8..81ea632c7a4b 100644
--- a/Documentation/filesystems/multigrain-ts.rst
+++ b/Documentation/filesystems/multigrain-ts.rst
@@ -123,3 +123,9 @@ inode_set_ctime_current(). If the filesystem has a ->getattr routine that
 doesn't call generic_fillattr, then it should call fill_mg_cmtime() to
 fill those values. For setattr, it should use setattr_copy() to update the
 timestamps, or otherwise mimic its behavior.
+
+Multigrain timestamps are only enabled on a superblock whose s_time_gran is 1:
+a fine-grained timestamp truncated to a coarser granularity can be no later
+than the coarse-grained one, so the kernel can't guarantee a visible change.
+The filesystem must set s_time_gran before it allocates any inode, since
+whether an inode uses multigrain timestamps is decided when it is allocated.
diff --git a/fs/inode.c b/fs/inode.c
index de207f2f95a9..9cc28306feda 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -239,7 +239,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	inode->i_opflags = 0;
 	if (sb->s_xattr)
 		inode->i_opflags |= IOP_XATTR;
-	if (sb->s_type->fs_flags & FS_MGTIME)
+	if ((sb->s_type->fs_flags & FS_MGTIME) && sb->s_time_gran == 1)
 		inode->i_opflags |= IOP_MGTIME;
 	i_uid_write(inode, 0);
 	i_gid_write(inode, 0);

---
base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
change-id: 20261119-mgtime-fc070b268bdf

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

