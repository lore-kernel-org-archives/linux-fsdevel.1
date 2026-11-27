Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756948;
	b=wMYIqA7k60LX6ttvkvmRZVIRw9kQ+o5jiBLUDWArckJEyoiC8ImbJ+PodyqZtZcYDU4Y
	 08ljbI/dOvMk0SxJ0rF1J+3IQJO1/ZP8Ps+s5jHjM2kfKGVe5gdYIuVEVcUFPNvIBXSMT
	 9530WOhRAtshVXdZYbtB/JXcWO4B+njM3pwLA4pndyxZF12kKeQV3sJqY3HLQpKJlFZAb
	 QP1I6UV2Jl6j+Hdk4FmVT4noINbY1NejnB1S9mFKklmPvg4q7MKT5v07DaZmpNi4ozXw7
	 AA3cWEpuzDB98rGz1slYZTcQ0VK6LuDVW9a4NE392ZFtdjw5WYFq00v5hqdrDkjWeGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756948;
	h=DMARC-Filter:Received:From:Subject:To:Cc:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:Date;
	bh=40mqIMs8z0sTbDqAhsd+jApirvc7mK2wiZYldUTZbe0=;
	b=ObBabmeBqTguhQ80of+yRofhreLfwaaAwF4XPk64EFscJHIN2iUVSK/sLCaU9VohHoeR
	 SyZHSD1xUgEli+0BPw7DqKXmTEeAATUw8S4CdEn8ar+Rp7U8xDEPwyQrZTFlFTZEdrGTD
	 OGcG7PsPIiySYqlYZYzr4000QwrLNO7kd2JEctqspjllN3YP9Q1xbxT6NOg5BCybypiz/
	 SqXKA0TgyRdkTYfroPjcWUDaBlZcLXapjDi3Ucy6KAbfsD1l5Pjni8oFkPz2ba31I9aQl
	 KbpgigQbXGDb2kqDBE0Dr4zc8IfFvp5wKw/YehURdbpUvfpl9v1/xi62XArN4A9korA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF33D606A329;
	Fri, 27 Nov 2026 05:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF33D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id E9ECAC9331; Fri, 27 Nov 2026 14:22:26 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH 2/4] ufs: do not take a filesystem NetBSD has mounted for
 clean
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    Ali Ahmet Memis <ali@iusegentoo.com>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Message-ID: <20261127-ufs-suj-2-v1@snowrabbit.org>
In-Reply-To: <20261127-ufs-suj-0-v1@snowrabbit.org>
References: <20261127-ufs-suj-0-v1@snowrabbit.org>
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
Date: Fri, 27 Nov 2026 14:22:26 +0900 (JST)

NetBSD has fs_clean at 2, FS_WASCLEAN, while a filesystem that was clean
is mounted read-write, so it is what is left after a crash.  ufs reads
it as Solaris' "stable" and mounts the filesystem read-write.  Mount it
read-only, as one with 0.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 fs/ufs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index cbb034a87..c204af7ce 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1135,6 +1135,12 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 			UFSD("fs is clean\n");
 			break;
 		case UFS_FSSTABLE:
+			/* NetBSD's FS_WASCLEAN: mounted, or not unmounted */
+			if ((flags & UFS_ST_MASK) == UFS_ST_44BSD) {
+				pr_err("%s(): fs is active\n", __func__);
+				sb->s_flags |= SB_RDONLY;
+				break;
+			}
 			UFSD("fs is stable\n");
 			break;
 		case UFS_FSLOG:
-- 
2.54.0 (Apple Git-157)

