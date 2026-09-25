Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88734C7532;
	Fri, 25 Sep 2026 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349437; cv=none; b=ZF2KdY5GQv5q2ePybDz3/17Hzw0JuRgS+adPCcHOuVy0QipVtcoU4SZtuvNVo02K3+GFbo/m9WcwyrekOm5u7i+qvXeVs9bQQ3CGWGpIAVjmnC685F+9al0V0IjDiTZKWz41Cd4I+m2lLpJ0ccj9fe0gYnNpIZb8BTbKgVchvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349437; c=relaxed/simple;
	bh=xkIT4tudCSqhllVJq8GUMPlMlX/DUcVCi8L1Y96pcJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pcOMIrn1C3FS0CjQm6AlJ/HClloUm33bc1XRCYwpYEel5zSKYhdzJW2cznG++kZceOPR6cKPfG1AV0BbTkHF4GVthXMxdLsHDMyhFH+a/v1M/5GlR272KnA9Jii8XsRyGORPVL0eqfP2/Nod13nLHnwpYp9l3kqCFceRBXRWABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaImm7Hi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaImm7Hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08421F000FF;
	Fri, 25 Sep 2026 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349425;
	bh=JL+Jy+iJw5r9KY4mg0ZtBVkkggAYJODtv083nmMPUIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CaImm7Hi3kfElwA5/GdIy6HAaQfri+1tXL1bqgum8Plr+boG1clAR+7uXcUDQujn9
	 zn3O0LlWrV34nMllP/f8xGHSZWZ2GxodiC94876Ld9BY8/NIxA3IcNd0mUSW4uXZU4
	 JZtd37kW/EitVP5mWFJkmobN1qiHDVaAGWtNZ6f15Brx5TJlcukvkUqlfzfqak5QE7
	 HmeNbDbI3I4qB0au2wUmwKtscIXbE2lQx6Ke4bWsFIOzGgu/N+rSaiyAgGMNHe+1Lh
	 8mtishyZup5gG8JCZiKtJQDaw4NuQXrfZFIlPjq1Tpe5Ja13VCReQ8edhoenHpsXhO
	 FgLaZh4I+jbPQ==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260918165105.1013792-1-ekffu200098@gmail.com>
References: <20260918165105.1013792-1-ekffu200098@gmail.com>
Subject: Re: [PATCH] fs: remove unused vfs_empty_path()
Message-Id: <20260925-maulkorb-badeort-mauschelei-568b848d8510@brauner>
Date: Fri, 25 Sep 2026 17:17:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xkIT4tudCSqhllVJq8GUMPlMlX/DUcVCi8L1Y96pcJs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtm5C7bO0t+/cHlk27Nv346/NTjx6/68zu8HjGoV6Vk
 n8elyQX5XSUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMxOEAwz+jxFlRdWlr/ObN
 PNpr9FVqd/AWFu17SYt4GixFJ5zYtjeJkWFp6Iop4pvne97XdxY4s+/TOxObHQvtXDUPT21M0Jz
 U6c0OAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 19 Sep 2026 01:51:03 +0900, Sang-Heon Jeon wrote:
> fs: remove unused vfs_empty_path()

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

[1/1] fs: remove unused vfs_empty_path()
      https://git.kernel.org/vfs/vfs/c/98abb2b35835

