Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6833121F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701720; cv=none; b=UH661xUIAc7Z/OEoIIfwFsEP1xMQSqeP1MzQ+wxAtYSWTSDhFxn/aODewFJolSZps9Ed8iXDaar3SId3PmBBMOVZ13U9YZ8DQbsiW1VpJUUNniLSdVzlxBoPbbrYrW/s4F/cx7GLWtrYMfzrhqSPhq2o9IAfD6qxe8tmv3+lm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701720; c=relaxed/simple;
	bh=jUOieeBJRHbn6Gns5XzNo7qWOQuSmiWxVTwypInjydg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAfXCh+BUiia7WlGqg3vkocl3ShoCAbzIhv4VbEhxmXh5qQ3F6qP8QVVaghFLF8FBpQQ6WUrtP0XcupWycoMNId6K+Cz48j8DToE0f8hsU3a03PioegS1XI/7bPkOG9IIIIPQjsR3kffl1bIjbb52tj2khvsSCjOEekrAU1sWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=thYfp+Kl; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="thYfp+Kl"
X-KPN-MessageId: 3ec1bf42-7c7e-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3ec1bf42-7c7e-11f1-b2a8-005056abbe64;
	Fri, 10 Jul 2026 18:41:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=NfVWrMGnL56cCC92A5genhZc1yTHyhGNKSqNIUzvOpQ=;
	b=thYfp+Kl4qVMewwYCXFIoI/RW1AZY88QalJ+KNUqVN5EPHU0JiRlPxCA7nQx1mrkD4ka+WYh4TFCS
	 ReV7h3UHvTpXtrld7OXMBVRgqUrdq2aBjQAxUnRNjJsID0UG2r36A1PCU+AYR21h12PrNkdGOZ1vu8
	 8XvE0om98api+b4OoNvW+aI7HkulnVraxafiU0iwwmVJpd6wvtwPw6tZ3/j2Qi75bhzJx3IZa1tUIp
	 MlvLk2o9NE/g9ukE5F9mHZdFfelIRlh6wsHnZXwPl5KNf68Vz+p2VqLQCimR/QdQoeG8HzBvDJDvJT
	 Q5ISclevmJkt0L341aBu6Rp6nkVPVow==
X-KPN-MID: 33|Mgjkyfbs8ofKkLUryk4oZJa8ElqGRUNCvJoIS67Twz2cpnmRIlzJmFx+/tGUcVp
 q/GiBlhaVttREoDbNxrplp8i+wytClrNzGDM00Eaf30I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XonvkG5AXzpijmVBjKnIK1b1UsNDVUck0+qJl6QIRRfrjAd8a/+6Y14EdewwJCP
 eNiliC/RmpWYTWlLL5ZfGLg==
Received: from daedalus.home (unknown [178.229.235.145])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3bede612-7c7e-11f1-91ec-005056ab1411;
	Fri, 10 Jul 2026 18:41:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 0/3] vfs: call audit_inode_child() in lookup_open() on failure
Date: Fri, 10 Jul 2026 18:42:30 +0200
Message-ID: <20260710164233.827744-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reworking lookup_open() to implement O_CREAT|O_DIRECTORY I came
across inconsistency in how audit_inode_child() is called in various
file create paths.

audit_inode_child() is called in may_create_dentry() so that failed
filesystem operations still register an audit entry. On success, the
entry is overwritten when, for instance, fsnotify_create() is called.
This is the calling convention in vfs_create() and vfs_mkdir().
In lookup_open(), however, when atomic_open() should have created a
file but didn't, no call to audit_inode_child() is made. The same is
true for the regular ->create() path.

On the suggestion of Brauner, I am splitting this series from the
O_CREAT|O_DIRECTORY work, so that this can be discussed with the audit
people without delaying that work.

Jori Koolstra (3):
  vfs: move create error && negative dentry case in lookup_open() up
  vfs: call audit_inode_child() in lookup_open() on failure
  fs/namei.c: update kerneldoc of atomic_open()

 fs/namei.c | 128 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 50 deletions(-)

-- 
2.55.0

