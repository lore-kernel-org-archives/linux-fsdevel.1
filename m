Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577BC481AA2
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909490; cv=none; b=QrcexzNiD8bJcw3k+remcUxMGt5V1+swRQ8EypkPUHqJboWDuw8FnX4cGfSPatLD6ulnKXK2k3jsdCS1bfbLRcU0O8/yfgq9AjXcmme4/MJlDR+LhFHWdS/wFJUVD43k3pKEN3GLLXlRjZS8qPJxQFjpfBHQ37wYMlYNz6IYwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909490; c=relaxed/simple;
	bh=lIA8aabNKMCFrlA8UeQ4nI6g2a3x9ifanmLK5DS246w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D92B5ryixOAV3OOwb4bOxbB7VE1vi9FVnhmcs8i+TPR8uIytVPt4MUU8kIdlPtc8bsERa3Ajpj0mBA0oHkor0mDRpTNnyvXfzmW65JY9/2Of/aqNX2yPjTJb8X1qLsFhcKfe+i3mLk+kCJURXSxfJpxYcvC/nfoPM38h63/tWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNpls3IR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNpls3IR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2A71F000E9;
	Wed,  1 Jul 2026 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782909488;
	bh=U/SUcc7Y4G3mXZ52pkc20YB11IA/4WGitT1TpvYT6CU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aNpls3IRkVeeD2s3oo3PxTIG5IfOe+xJmEF4eKgBX4ykDs60qYDe8c0W/2IIkr8D4
	 K84/+ySNzfbp38Om0ePwFQHGYGYcyolHbo6mzlZbI/6kCxMjcyPNhr/F95qcdg/i5G
	 NwzHMAxcELkiL2AeKSbxDepFztRGr2ht5TMLzPWB1bVtwx1MpzL7kvVDX3U90hnSvK
	 DxxeseH5ABlbw+brO9btNdFE2SN3O80GvIzyBCEKmubQCtheBujLlfGUNK6kHo4bB1
	 OHkPbWYGzZjToQJt2YVvRI7P2RTB+NIec/blHb4WlMMSh/f5hK0tgzXHdzseAfQSfJ
	 bkVWW2rFel92Q==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neilb@ownmail.net>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, linux-fsdevel@vger.kernel.org
In-Reply-To: <178290671516.27465.15984496764174914338@noble.neil.brown.name>
References: <178290671516.27465.15984496764174914338@noble.neil.brown.name>
Subject: Re: [PATCH] Remove excl arg to ->create inode_operation
Message-Id: <20260701-zahnfleisch-manisch-chiffrieren-266179f4694c@brauner>
Date: Wed, 01 Jul 2026 14:38:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lIA8aabNKMCFrlA8UeQ4nI6g2a3x9ifanmLK5DS246w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5cunt/K2w9Z8Wm+6yJmu1ra7cW/avPvnHVf774U8Ha
 2McC56e6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIKnGGv7K5Ol3c+wxElyrZ
 cirI1znpbWlz+H7JpPZHkUZXZdKxpYwMB6uupBh+T3QTfT8h9tGp0pXOhVm+z19kGK3unHKz2G4
 5DwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 01 Jul 2026 21:51:55 +1000, NeilBrown wrote:
> Remove excl arg to ->create inode_operation

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

[1/1] Remove excl arg to ->create inode_operation
      https://git.kernel.org/vfs/vfs/c/cfbd57798c63

