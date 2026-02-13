Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFC352C3D;
	Fri, 13 Feb 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979486; cv=none; b=F2lco/aaM/mHhPGm96kZ6Dg30E0Q6BbuHsSYr2HdhiAmkHNva2WPEeXu6brKvWkKSO+HaSlK9il+1G066rjAoqc1Mly3ewfNytaCEypcUtseVSZIuc+6cwjnzmFtttq+htsanK3bTTf77XbnxpmqTEQ35vVNSySmUD9UQUHfCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979486; c=relaxed/simple;
	bh=4r5sYOsuHx9pVkMSBV3kNbZLBG/Rokt5knXJtofhoVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAA84LxzR3MHy4xDVebCO2YQwudrYsWtjGwErO3RpfkDH372sNrpxNKnP3DVT6uFYgs7mWvQy0eO4kc4UrPlPBcpowH5/Y+AbsluaK32mWcF1Dzp2VlKtP4R2meUMdZ5UPuN85NtVCl+IlwWhbIOUAcfFnIEX3mHJEwxGRLf0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ9kVlEu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ9kVlEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DB1C116C6;
	Fri, 13 Feb 2026 10:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770979486;
	bh=4r5sYOsuHx9pVkMSBV3kNbZLBG/Rokt5knXJtofhoVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZ9kVlEuY/cZJZ2OI6PD0MVIdR5QAqj1+4YlAQZkhZ1nUmbAY8QAAccQLSEaV9zQ4
	 wTHWp891GzX1I53lmJWPkTBv82+t3IDgfiOfU/d80kPyYrBAo1kAmzzsQThIEvqb9+
	 QX9miuiJQ8kF9uYXAwxs8WhOXu4TaOHbu8MFvL96Yol0fO+7zRGz51XG1J98bFqq9X
	 EyxFRAL4KYoByhZfDoiXlIMZBYFPgRgczMoG+RmikJSqaRsQJ3zqld2xG2Bw9eXLeu
	 eBwfTFxhSIA2EfJLqODzgkWh1bkXR7oWEG+tbvjn3tIWntuH7MxT90ev6lDqp877Qw
	 dAzO3+IjDGjbg==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/5] proc: subset=pid: Relax check of mount visibility
Date: Fri, 13 Feb 2026 11:44:25 +0100
Message-ID: <cover.1770979341.git.legion@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1768295900.git.legion@kernel.org>
References: <cover.1768295900.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting procfs with the subset=pids option, all static files become
unavailable and only the dynamic part with information about pids is accessible.

In this case, there is no point in imposing additional restrictions on the
visibility of the entire filesystem for the mounter. Everything that can be
hidden in procfs is already inaccessible.

Currently, these restrictions prevent pidfs from being mounted inside rootless
containers, as almost all container implementations override part of procfs to
hide certain directories. Relaxing these restrictions will allow pidfs to be
used in nested containerization.

---
Changelog
---------
v8:
* Remove mounter credential change on remount as suggested by Christian Brauner.

v7:
* Rebase on v6.19-rc5.
* Rename SB_I_DYNAMIC to SB_I_USERNS_ALLOW_REVEALING.

v6:
* Add documentation about procfs mount restrictions.
* Reorder commits for better review.

v4:
* Set SB_I_DYNAMIC only if pidonly is set.
* Add an error message if subset=pid is canceled during remount.

v3:
* Add 'const' to struct cred *mounter_cred (fix kernel test robot warning).

v2:
* cache the mounters credentials and make access to the net directories
  contingent of the permissions of the mounter of procfs.

Alexey Gladkov (5):
  docs: proc: add documentation about mount restrictions
  proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
  proc: Disable cancellation of subset=pid option
  proc: Relax check of mount visibility
  docs: proc: add documentation about relaxing visibility restrictions

 Documentation/filesystems/proc.rst | 15 +++++++++++++++
 fs/namespace.c                     | 29 ++++++++++++++++-------------
 fs/proc/proc_net.c                 |  8 ++++++++
 fs/proc/root.c                     | 22 ++++++++++++++++------
 include/linux/fs/super_types.h     |  2 ++
 include/linux/proc_fs.h            |  1 +
 6 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.53.0

