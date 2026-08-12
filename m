Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72660376A15;
	Wed, 12 Aug 2026 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519543; cv=none; b=ce+HiAn8Lt6dEfxTQMKjYTHPyLBa86MUghSLuzoIDdrTu2LoYox7XRwS3kgBByAoghv4bRhTRwiuWnQFzlrXXx6vr2Qpk5CnNqXmVapbjhIU0aSCe/KfDtjB+fsuBn0IYLBcyIFbbIZCqyOyAchzTFJR1lOVNl2TC1TsfDMpoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519543; c=relaxed/simple;
	bh=gF22Uzh4L22DUJColIOdJ4EP36FAX7Tul36PwhjHYog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=omv1kIYr/vSDKbFDfUICk9Di9+ET+AC/aBe4ZNrBhu+svFzrmN+RBBvT/0+dm5aTFTbKRQufbZuopkJ9gm0sBqcm0p5YeO6F+IWM7J0djO8rIxfdvPn6xgoftHEVC8HFUwn00Vem2F4pXCRfyEaM1GReYG34i40aHK6CVjBmGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoR1tUgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoR1tUgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D9A1F000E9;
	Wed, 12 Aug 2026 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786519542;
	bh=gxgyadcfQBJr3Y9rhl/dWk5QJG6BPUzTC5YVto4TqhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IoR1tUgpw4DUeKhB+vHOBZa2krzZMa/KKYGSFhRqkRDjBl16U2NDZd0RSJXExLQtx
	 XRlu7idJoOmZobkGjyADdADVbuGBgUwm/I8XOGXsjIL+m+Tm6ckUHvGA5jpvp9L1KR
	 bhUYSx6XA+pU4UL0DQoEljuN0TuAQC9qO3gy/6SpfKkVXeiGNq0FNrhVGJJYgPhNVg
	 7X7JjiEIzaBJuZSnaRdvZVM949qGqDiMXrW/W/XyJxq4BVSiEDLA29AWyNw3cYw9du
	 2tgC7vnPRehqMTbf19tlf0005VCHpFs17KohMTn1I5a88h1ummEjWMO++i4LYfs4s7
	 O5zBRRUhliCFA==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Yichong Chen <chenyichong@uniontech.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260805024149.935769-1-chenyichong@uniontech.com>
References: <20260805024149.935769-1-chenyichong@uniontech.com>
Subject: Re: [PATCH] fs: remove stale inode_insert5() kernel-doc parameter
Message-Id: <20260812-injizieren-samstag-badet-4019cd14bf00@brauner>
Date: Wed, 12 Aug 2026 09:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gF22Uzh4L22DUJColIOdJ4EP36FAX7Tul36PwhjHYog=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVyH/5zXz2uZbXerkvfj5WEZxnflzqZ9gd8/aP75z4S
 cbNYmebOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbC4sXwPzbs2uo9xy4JJOpp
 BhY9fnfr/6nMz+eSPnnuf/bKW3+OSRfDX7HopQbfjnpm9h9q99FZ+b//18neL3mbFkV+Wm8Ysnv
 JUn4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 05 Aug 2026 10:41:49 +0800, Yichong Chen wrote:
> fs: remove stale inode_insert5() kernel-doc parameter

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] fs: remove stale inode_insert5() kernel-doc parameter
      https://git.kernel.org/vfs/vfs/c/28c7347ac297

