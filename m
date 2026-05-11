Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CDF1EA65;
	Mon, 11 May 2026 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508061; cv=none; b=JNQTTVKDmTYfMRSHgiuiVylNwaqu2ihOmTBhU1f5vgXaVtA4qeGAn9hHUjeSClxX09/qZtnIsAlqYnfaNrhw6TBnfiRqltx4a09TgCKA/j+wkvBYkHJyGn+PZVZ3q97A/fsWBRfRWtJnhxebCQicvoCmOId3frnwR8gx3yFhBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508061; c=relaxed/simple;
	bh=HY65l1AD7lJS9rR8EAszjnjy7yShnjTmAN0/RZjhmC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkA5TMDnDIXXe2JkfeJWezEIsZ1iVp6EqVBB1WgMixJ9azYge2tOaBemJBboT3bzxr2MyjreAacjzwP3a/+A7rlhUms4ZSxmYJ2POR9ZlpunBvdMi0fNke1lYcan7ooPmB2uuNrrtoubUWCpQdo3mglN6ukgonF2bVxEJ8PKJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9RM8aF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9RM8aF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCB6C2BCB0;
	Mon, 11 May 2026 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508061;
	bh=HY65l1AD7lJS9rR8EAszjnjy7yShnjTmAN0/RZjhmC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9RM8aF3ltIEOwD1UEVqIGlXg5y6DKpx3L5B4O19r3OqBgg1I6LGtb+CKvNSLj4+V
	 HpkYoJBf/HxQM46oCmJyffkC459hVAZdTHwuf4ATuo25NWtjN4yJeMG+hjqaJfHfDS
	 PNJ77+/rYLPBDwy7FyCfJApadgC1/7sHsM+NwoAnr+jTqEzrukVeg7WpTlm03/e3oK
	 gcPhU+kKx6gMmYwdFj6XYTAZWfmJ1CLBUsT7e4zGRb5e5L2NyMeAAMKVfM0Kp3o0xs
	 Nm0CsZkCjazwaaskLRjd/Bcx+JDkc+klbPtr89E/PbRRnn0KKxtZ2W1w12qidVtHEU
	 Ho181maioBerQ==
From: Christian Brauner <brauner@kernel.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>,
	viro@zeniv.linux.org.uk,
	jlayton@kernel.org,
	josef@toxicpanda.com
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	changdiankang@huawei.com
Subject: Re: [PATCH v2] nsfs: fix wrong error code returned for pidns ioctls
Date: Mon, 11 May 2026 16:00:45 +0200
Message-ID: <20260511-krass-takten-d4ff45841341@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507112301.1042757-1-chengzhihao1@huawei.com>
References: <20260507112301.1042757-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=brauner@kernel.org; h=from:subject:message-id; bh=HY65l1AD7lJS9rR8EAszjnjy7yShnjTmAN0/RZjhmC8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxPhSXnzxzlu31L82Pb1csbDlQfPOSy3a9I3yTleUYr /pGX9c36ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiItzLD/7Q/k55lKUXO5w7t se7S3n1c+eTuja6eC94vXpl+sSRmiyPDT8YSpdgvLQk7ooJcLu258s/68YroyRU1LE8UTstULWP PYQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 May 2026 19:23:01 +0800, Zhihao Cheng wrote:
> When executing NS_GET_PID_FROM_PIDNS (or similar pidns ioctls), if the
> target task cannot be found in the corresponding pid_ns, the error code
> should be ESRCH instead of ENOTTY.
> 
> This bug was introduced when the extensible ioctl handling was added.
> Without proper return, ret would be overwritten by the default case in
> the extensible ioctl switch statement.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] nsfs: fix wrong error code returned for pidns ioctls
      https://git.kernel.org/vfs/vfs/c/725ecd80688b
