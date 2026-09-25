Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A343DEC1;
	Fri, 25 Sep 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346064; cv=none; b=jDlzimXob8OUgYD1xUB+YqUpPrUSrsT0v+9+61f1MiutxvIFwWlVONCj3ZQ0s/fQ1bI+ZFLq5YQYDSLxKki14J+H5UUsqh/BBoJDgUtPv6odc7Wlktn1pCTxyadwCkaZpgySKi+pbMugJJd2BN7puGrQ6oFiyKFeGSx6Mx72k80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346064; c=relaxed/simple;
	bh=ipYU8e78ByEhWH/1W0gJkLC172mJp5qZEgqiCFKsZYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q3gN49eEQ7/GQj0II9pfS7yqIX3Q/FcZWvOWYMdzEvM8dJ9dzUYfTfMNABsO8H2YQThUMK0dklUEAzSVYpZcZuqVS27Yba63Ir/4eke//h3qR7aaAWeEAclWtfSdKgYsU8DqVSpRfPLWepjxI3Hau5uO0Zsi36uNUq21aWVMwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhfTnzgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhfTnzgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093321F000FF;
	Fri, 25 Sep 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346062;
	bh=Y8bbhgovMLJiV2/8MU9E7yMpXiD1DeJOffuWDMO7waQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZhfTnzgCuikPATdpnPcvJA7soMR0WYKkzTl0ydiV3QCy4RjCJIXMnlFYPl1xSnLpt
	 fN+/mBRdZI0neUlyQ6PD6eTRjNRgqH3xGz+9MvzcqejpS7zHUQ6VXOK95XjzZwaDU2
	 qwz6vip15hKyRFBj1BBz5laA7BojNd/IhjPBBHzhHdv8IenXO6A7W6PuDrGHcINDiJ
	 9kOaHB4fnQtULK5K+FboODTSrHuhVdvFxRK+CnVZjA9VwMLQA0/8NW2TNAmHJUZ8+a
	 dUf2YRRogQh95q4eqPn+dKUF38/d4xlgrvFv5Jbw2y5996Nu4423RX2Wb1Wi0XcJjA
	 pOIBwR39jNACA==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260912073250.51074-1-kmehltretter@gmail.com>
References: <20260912073250.51074-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] docs/vfs: Fix the struct file_system_type copy
Message-Id: <20260925-sachlage-reinigen-auffressen-5bdd926d423f@brauner>
Date: Fri, 25 Sep 2026 16:20:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ipYU8e78ByEhWH/1W0gJkLC172mJp5qZEgqiCFKsZYs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRta/ZsXHOgtqwiafmuG4dq4uOblJfNvfK24cgpncW8N
 5OMzsg96ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIxSGG/6GCrQcmrpxXLJMv
 ItXJ8MeNXTSGU0lhgo7JUd5X77eEdTAyvLBbW/Dm+sZDnVo93x6s2u98fZLMvItN6zU3BeyViOi
 IZAQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 12 Sep 2026 09:32:50 +0200, Karl Mehltretter wrote:
> docs/vfs: Fix the struct file_system_type copy

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] docs/vfs: Fix the struct file_system_type copy
      https://git.kernel.org/vfs/vfs/c/392f5390d5d8

