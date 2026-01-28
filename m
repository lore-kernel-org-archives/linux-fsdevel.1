Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC036EA82;
	Wed, 28 Jan 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622462; cv=none; b=qFKMPPFL+Fy9YYSy5edCbqd/POIK8r9t/KxdcSyAqlaoQ/6L8vzGSeSA6Q5eJJenefk+4wiWUXjqZavPmO/gPjeJyRXKWSOXMYRmWXpzi/OCCjtWpjNXTCngFADr+u71urHe4pPCzHqsrejJYoJTinAoSMVeWugKOT/YuiWCX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622462; c=relaxed/simple;
	bh=74QJ5LsClE4mCZDr+abjfHhR9yswho0CupEbUKZ7XEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sP3IElCa3eFkRghJsLzoADY22xaskeMsYOuOyfrieN0fYtt1/t8i5lSaZRhyEnWR3BSe5w465cJ1qd1BjpUJ2t/a6X7lu8o0AxBEHnSLAztrbAToCQh6yZHLDIeL3kS8aFZFPt8clzb9vhqbqmUE9RJkh4YyFkVFyWZ/3dafmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amL04Fp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amL04Fp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13851C4CEF1;
	Wed, 28 Jan 2026 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622461;
	bh=74QJ5LsClE4mCZDr+abjfHhR9yswho0CupEbUKZ7XEE=;
	h=From:Date:Subject:To:Cc:From;
	b=amL04Fp5FLXyk+wYIRT/kF4Fp15vfY1WR3XuQ8ma+/5Kuau4GcJc4KEI4CYA7Nkte
	 2HF4KXO+MKMKtnpctO/2Uqj8BfsOK+t/ZYpoc0HYeAVBirHqmaTvo0JPRQ/SuVnQuD
	 D82pTbbiee6HULDVgNIYOetvVt72xGFSCAQul0wgZ1OpmkqgANfUa68VNINo5spDSi
	 oixhyiYN0+LkZUiw6PEEA+YKEwWxOB1kVYLQOLvP3LRlR8Vs3fVjFhne3mFHs+Cv29
	 zQnGneFf+YRigK3kvjhc73WhztFU+IDCbgu2SXUec/gsd+5zKgX2SnzzEbydTBEWVc
	 F5bWs1R9906Qw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 28 Jan 2026 12:47:14 -0500
Subject: [PATCH RFC] vfs: allow mounting inside a container without
 FS_USERNS_MOUNT by root
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-twmount-v1-1-b1d446362da9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyML3ZLy3PzSvBLdZCNLI0vLVAsLEzMTJaDqgqLUtMwKsEnRSkFuzkq
 xtbUAHmXzdF4AAAA=
X-Change-ID: 20260128-twmount-c29299e88464
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=74QJ5LsClE4mCZDr+abjfHhR9yswho0CupEbUKZ7XEE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpekuvq06RozMOhLTebbFQAxgqtCpRjT3dMsnRf
 x2CRkMg4PeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXpLrwAKCRAADmhBGVaC
 FeCkD/0ZjE7RhBxcxhzPIbI+glKqROQAsKtYS8MRJuK9OsGC3S83SsVwHwFjkQDWLtv/sHFNxtP
 AHk/0tpQDfnyH6ELop7bzuF32sbl8zg0YRmqFjHX1kyCHsRW+37eNSN0pILVxsYQPC4WO3lSJqZ
 jc4LxLODRNRdX3M3dTsPmYd7zpsvEqvP+cdha7Zn+oGnvbnuNIvuTXcZ0XqMcfNIEG1RcyGytg6
 tsOBAW095qbMFzs3jwBP6+gUJ3VG/5R8U3U/vxTScNPTPUmR5NJgGKreMbi1dTKvHzY3GJdo20I
 eQCAT47nSyK68MvjJVWuIZ6ruLpV0P0vanIHKlRorc1YdrH/SPHBiCNbZzWBXxPYnDI+5mLh77Y
 DXFeBucN76c6KvIVc42sXslik/W3cvJhtag1NjfTS8g3RF9wXqLDZXLVNSGCfWcWDdYLFCJ8aZ4
 TPjOUQGfS8NjZypjNP5zyQciw0Jko68Bo+kFvkd4D6JhLw8EJTCVekC0HINnYc3xn5BFrTLWCSJ
 qWTQSExanyurTeoSqsYcq0d4wXnB2wiPPtnzDmle11oWYopGxLLIRLmS5C1BNycJCD9mb0Zmc03
 uIt0BwL2q8YKBUPtm2Npsxd5yG8oydlndcMep8OrxhKTvegpFRDZrpYnsueR6+f9sS5pzspLpCO
 bHycSwOVqLisabA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Meta (and some other places) have an unusual process for doing an NFS
mount inside an unprivilged container. They do the fsopen() and
inside the container, and then pass it to a privileged daemon running
outside that container via unix socket, that then does the mount.

Commit e1c5ae59c0f22 ("fs: don't allow non-init s_user_ns for
filesystems without FS_USERNS_MOUNT") broke this scheme, as the fc->user_ns is
not init_user_ns, even though the daemon doing the mount has CAP_SYS_ADMIN.

Add a check for CAP_SYS_ADMIN to get it working again.

Fixes: e1c5ae59c0f22 ("fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
We've needed to revert e1c5ae59c0f22 for the last year or so in order to
keep NFS mounts inside containers working. Does this approach seem sane,
or are there valid concerns with allowing this that I'm not aware of?

This is not well tested yet, hence the RFC.
---
 fs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3d85265d14001d51524dbaec0778af8f12c048ac..d06f3e5765921a2ab341827a95dcd663c38cb594 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -738,12 +738,15 @@ struct super_block *sget_fc(struct fs_context *fc,
 	int err;
 
 	/*
-	 * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
+	 * Don't allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
 	 * not set, as the filesystem is likely unprepared to handle it.
 	 * This can happen when fsconfig() is called from init_user_ns with
-	 * an fs_fd opened in another user namespace.
+	 * an fs_fd opened in another user namespace. If the user has
+	 * CAP_SYS_ADMIN in the init_user_ns however, allow it.
 	 */
-	if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
+	if (user_ns != &init_user_ns &&
+	    !(fc->fs_type->fs_flags & FS_USERNS_MOUNT) &&
+	    !capable(CAP_SYS_ADMIN)) {
 		errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
 		return ERR_PTR(-EPERM);
 	}

---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20260128-twmount-c29299e88464

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

