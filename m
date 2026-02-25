Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38A393DE7;
	Wed, 25 Feb 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018721; cv=none; b=AGm3mBmEHmPhdATUs0t/8BYanG/2uNEmprKG+BmUC+NdTW6Nz339YcHvcjTXqKJUOswrP9K5xtj32Dc/d89JFepjxjShdqnrskvueYXci062lBL5Xy07GaWC/kKxvF7LE/cKaD1jhw/9a5dfVPqs4O+pFPvq4ovu6AE0HqEcwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018721; c=relaxed/simple;
	bh=LWhFIDyxCL4zSWPwychKIFM78yk9+CM8VA7ArlCfhpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJtak4dnTDeo7yCPicuZBA9q0UQmMO5ia5yFOMsz9EKQcWkrGvGy6JRNnqw9Pat9tGzNyySGMQan97nLfTEQuF8RSSpCd0hZXi2pML+JBzTHalfMeFmyWYPLiv/LkJoCcq88zEk4f8OC0oStb9OKjeUs9XeeZrFCT2esF8K247o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IVvDgyBK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IVvDgyBK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PA0U99V8U2+zRTsAYsXjZi6/myHrUg2mZVBgwWFjUrg=; b=IVvDgyBK7SJYXaLGrbN6mSmQk1
	tAG6I0feXWYKPupkOvh6BlgTeZ8CEjy1O00hoFVLVLahUMLP8CHvDN0Y8kYu7oRT5jrL9Va9nc7Na
	bMbRV2FUoGH+7UOfY5AWL3aus6eUynroij/MNT68DRU1VpbV/3w7Fau/kGA80WxHroMFeqKYyq538
	vjVPYFbwrD0/4W5uqYvO5Ue1Ei3pyA45S26ul0hObezkTMBGELO+DbGhKBDBdyfSXG+yF3S/fJHZU
	iUGTh27I8nV3SrIA2D/g6eBOom2Ita+LbOAUnSZ7co8/cOij2Xrl3kLEmWk53pducaMoGCLuH+bss
	+67//mQA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvD0r-005Cn1-1Y; Wed, 25 Feb 2026 12:25:05 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kevin Chen <kchen@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v3 7/8] fuse: export fuse_open_args_fill() helper function
Date: Wed, 25 Feb 2026 11:24:38 +0000
Message-ID: <20260225112439.27276-8-luis@igalia.com>
In-Reply-To: <20260225112439.27276-1-luis@igalia.com>
References: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow fuse_open_args_fill() fuction to be used from different files.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/file.c   |  2 +-
 fs/fuse/fuse_i.h | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1045d74dd95f..ea9023150a38 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -26,7 +26,7 @@
 /*
  * Helper function to initialize fuse_args for OPEN/OPENDIR operations
  */
-static void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
+void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
 			 struct fuse_open_in *inarg, struct fuse_open_out *outarg)
 {
 	args->opcode = opcode;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 173032887fc2..f37959c76412 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1588,10 +1588,14 @@ int fuse_file_io_open(struct file *file, struct inode *inode);
 void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
 
 /* file.c */
+void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
+			 struct fuse_open_in *inarg,
+			 struct fuse_open_out *outarg);
+
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-								struct inode *inode,
-								unsigned int open_flags,
-								bool isdir);
+				 struct inode *inode,
+				 unsigned int open_flags,
+				 bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
