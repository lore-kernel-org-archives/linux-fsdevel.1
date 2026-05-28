Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847FA3ED3D3;
	Thu, 28 May 2026 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971241; cv=none; b=mBX2gCbNpNb8xyZsE6c9dKLd83lZiKFhP1W+QdN693eCTbOLNewb8VvqSNOY1odyYSwsqqtDoZ97nAmLxy0tfP2RuQoNv9bOAsZ45QUWwU+XoO7CD/0D5MI/4JeRnZs7OSRDJiWArnMCMm/Z2ydDgtz73v3/4UcAzGJXbf9Il2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971241; c=relaxed/simple;
	bh=NhMSvxcYUBvMFC+CLoeBv8Z5kioXIf4n9sPw41Ub7OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5qMr/1/CrnD1kGqHNOibdM4FBmiDUhTKkGEUtCikaY+38SWn2SrjiaB0hvjqWk3MdVbZJNeBR7Feaw0/o7HGku0WtOVT8fxErKUclnwqHvTz7ESA+K0sxlcw+R/7ts96dgOHNykctNKAmXoH5iEm98tkmmuIXhSkLNrrmbzISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+/zrLbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+/zrLbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654101F00A3C;
	Thu, 28 May 2026 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971238;
	bh=vxXOYFyz8sKTvyaliMCr3I/57MqhwVsTLcMv5Fkt+I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X+/zrLbifMKOAkyycltWLURTYH9RDYNJ9ylOfH0hMi5p7zwRJFga953bl7uA6mUD1
	 VxeoZDxOVAevnE0E3FfmEPkcqMI2ZOUrgMvLoQxWJJriKKAgbdO1yUid70vz+2WMCL
	 ha4nUDrYGZV62lnpseoYLwWvSGzBUdHdNxR44DQESJhIxr03zMmFv0KlMiElvcgDy8
	 CgCT/vha5N781MvniJl7DAiOIoj/20OwA8VAl6jN7B6qEHaglWSMRZJ+0TTRp7wPt6
	 TfE+RKwZwW2zlBLy/lHYExYlY3AmVjDsHKI+W5gzWmvnjsIT1THsS1A5EW5WI0cDPt
	 Da1Z1hDV44Y6A==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: retire stale comment in fget_task_next()
Date: Thu, 28 May 2026 14:27:11 +0200
Message-ID: <20260528-abbekommen-mundwinkel-perfekt-d0710b6ae39a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522142152.1515572-1-mjguzik@gmail.com>
References: <20260522142152.1515572-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=brauner@kernel.org; h=from:subject:message-id; bh=NhMSvxcYUBvMFC+CLoeBv8Z5kioXIf4n9sPw41Ub7OI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRJmCwyjnNxTN73mzfrb2Lw1cinn9vNHHeHv73XdSqEm edmZ2BERwkLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ8dRl+PNcOdarY73HOdqaU 3+upTxw37MiudheccXObfNY5CbU5DP+s05gShQ05716OrDZlNd5w2/DQ+RmifCb9p/mSUt0uuHA BAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 16:21:52 +0200, Mateusz Guzik wrote:
> The routine originally showed up in e9a53aeb5e0a838f ("file: Implement
> task_lookup_next_fd_rcu"), afterwards it got renamed and started
> entering RCU on its own in 8fd3395ec9051a52 ("get rid of
> ...lookup...fdget_rcu() family").

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/1] fs: retire stale comment in fget_task_next()
      https://git.kernel.org/vfs/vfs/c/d24576fddf64
