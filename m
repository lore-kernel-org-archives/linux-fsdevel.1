Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EE3947A4
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251656; cv=none; b=K3mCawZE1Tikb2hmmeREAGsILf0d+7IRo8XKUkKNfmX5W2bKWki2ex30Ywxs5lxLN4nx1J6v7p7//eGUyFlsBl9brq/pL/5GBRk+0GKm913qw2hngUeu+z2WhY9BAkvsEGRPeMdD8DiPvW8yL8OAEE04t5AQ8iqKfHH3t274o2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251656; c=relaxed/simple;
	bh=ITbap9DPpzUHkoWoO5kTldCq5lcmwN4rGgz2nAF/sIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK5pMvemrDe4LUhuVDA/2O6jOwDWgi9RKvawO5XlMt0HfFmPJ46Wt/edSjFTMfK4v/KTsIfCmx0MEkTdFvNjDt3vnkY4RTNrDLUR5nURN5aDYCcJ5ekxZ2YlnPB+UteR9QSwHHSDBth9N/kow1qIfXQUU8Pq03YrRqoTg5YBxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=QuacYR24; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QuacYR24"
X-KPN-MessageId: 4df95bf0-5d1d-11f1-8aa3-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4df95bf0-5d1d-11f1-8aa3-005056ab378f;
	Sun, 31 May 2026 20:19:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=DHKIaJvVawa9lI2EeU3t15iWZNFx9FU5KWyPNAo1oS4=;
	b=QuacYR24m6W+h4ijrivJRokP4hJ/XUJvq9cEd8MIAa0ZHSRov9ZsDdh0G8slC9bRzppbYfhKkuWtt
	 bNN4ddSnIdS58kQ2Qb1vZ+SF+LVeepQAcNz2/8CoLm0MjBJkGcRbYbegGp0ylBeyPecIJI+yg7q2BC
	 j5zuO0JgF+LXJxfrqTrjyO5bo/R0zlXFHgrvN4AKPGX5in1qVLRLdYDe3Ff7ALuuwxp7znaH9TJo6d
	 zv75gSJKNWr3V60WqjQCR1gKcwkf4sWfqf7oRiQXdfVjaK9Q5prL+njSCf3sG0eyoBMdZYvDibb/tw
	 TfThiGhqN/JQdSPd+gD2+WLGaeqv73Q==
X-KPN-MID: 33|YAQHyWQ7JD6veSExEtykrt3oABei5IsTnABbCFH1PeXFt/yCsvhiMrd96/n7wM9
 H88YrIToODmKYzI/3rt412RaGKIyb0SElFQj3ZGOmhUY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HxZLdPCzo2c+vmAoM2bqOsiTtT+IrmfZ/M6QLdVzvfT6hJuEflQk7sNmfojlFdL
 zPfOxWy4c7P5wS21oRyTjjA==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4db295d5-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:46 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [RFC PATCH v6 2/9] fs/namei.c: move create error && negative dentry case in lookup_open up
Date: Sun, 31 May 2026 20:20:38 +0200
Message-ID: <20260531182045.171711-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531182045.171711-1-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

O_CREAT is stripped when create_error is set in lookup_open(), so when
lookup does not return an inode, the case

	if (!dentry->d_inode && (open_flag & O_CREAT))

is always skipped. We can get rid of this cognitive step by handling the
error case first.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 137d9fffbe80..4cd132fe3981 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4499,6 +4499,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		}
 	}
 
+	if (unlikely(create_error) && !dentry->d_inode) {
+		error = create_error;
+		goto out_dput;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
@@ -4518,10 +4523,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (error)
 			goto out_dput;
 	}
-	if (unlikely(create_error) && !dentry->d_inode) {
-		error = create_error;
-		goto out_dput;
-	}
+
 	return dentry;
 
 out_dput:
-- 
2.54.0

