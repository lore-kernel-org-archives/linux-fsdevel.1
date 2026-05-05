Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CB239E9B;
	Tue,  5 May 2026 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958584; cv=none; b=iQKosz50fzabUdhKwdyk0i0tWLKrXNSoB2dnbufdllT1FQ989yESBTK5iMEBMkY3hjBY1+yGDt5hIutDbU7+s00onKiVCpvjopvqDRd7vbbVrKYglix2bMtN/kYNEJ6ZL4C7rl1NZFySxO6H9unDxxidOp9FmMDQRc5MF85rYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958584; c=relaxed/simple;
	bh=jQ1Y+8aK8IQo7UeyGoegW71GC4dwqnzp8ucctb1nn+w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=honHP3BvCsXoRxrn83OpbOhE9CtaBgIUPecD1yNStN8iX87ApaOHXom5zZL7BOqiPqR7+P68xQxYo1CcOFmmea5jPlopROuoPX9acIkrVf8M0SXKz7bioO0EGeLhbWgYbxq8dXWCbR7Wg1Zx0/6vhjO5T63R7G93ptK6C1Jn/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWWdnl89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWWdnl89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70539C2BCB4;
	Tue,  5 May 2026 05:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958584;
	bh=jQ1Y+8aK8IQo7UeyGoegW71GC4dwqnzp8ucctb1nn+w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cWWdnl89h2C7xTO0gt+clgmLPinulJ5Hrww7R/wPo094XtOd1Cv0O/llMIeXwV9UA
	 m+9A2ozRQGKJDHrqt6H+VcOAfOtBJ1LzLg4a0WiKLn9maXztkdOzyCnkndoZaYcJ9Z
	 YNdJ7n9L07bF1A5PGOd0I/dyRUSgniV9L+xVR/Sq3R0wSAr9hg+dAhW2Eo5Lbm+YeZ
	 vVcCcHmuT9+ryDzDDePK24T7ZxZnWIlK9PFSmacgICAMgVia/ClFe5Bam9RKwUUxfq
	 /VsuEdl3T7AgvXsScL3mALU/n8qkPOFI0Ld8KvMkqFduVBhZ10psvmoU6zmhKP4lNl
	 1TmdFqwlYz1ug==
Date: Mon, 04 May 2026 22:23:03 -0700
Subject: [PATCHSET 1/2] libfuse: new mount API and SYNC_INIT fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
In-Reply-To: <20260505052133.GR7765@frogsfrogsfrogs>
References: <20260505052133.GR7765@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a collection of bug fixes and cppcheck cleanups for the new mount
API code and the new SYNC_INIT code that landed in main recently.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * libfuse: don't use SYNC_INIT unless asked for
 * libfuse: always send the subtype to the kernel when using fsconfig()
---
 lib/fuse_lowlevel.c  |    6 +++---
 lib/mount_fsmount.c  |   13 +++++++++++++
 util/mount_service.c |    3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

