Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A62D8378;
	Fri, 19 Jun 2026 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859411; cv=none; b=DY2RgjrQ7Hvcl7FVhMJOwDCb6LXXSHn3+rAmqC+oMpKxtw3xCeP4DycLrNlUzYPEojuVPj2aHqesNR3Go7eWl9Ovh7k3XfERyQ3oTOa2uJjCnSQEYrq6q9SJPTiG+9RQMjE2BYXrFoJywH8BWvdYOvQ1gf5SSCIhzUU5qtfKe4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859411; c=relaxed/simple;
	bh=axCAdIFEQxkQuujOYdiR30C5OZXhOTjQuJDwDicysOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RPJmAquVVZPnYEfE36tL2Z073InDTX+I0iRF5Ab6yNuOGh2YtsCKufuJSEcE8qoLYhlH8UNWMyKgosXR85GqUhUCZbLgkis+PsBMfU+SnO8y/XfKvK09Oc0M/UrgOQb63m+NXf9wYJnB+tQ+8J1BQfYvOk6b7anUJHbz0bfkK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckzMoOMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckzMoOMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A1E1F000E9;
	Fri, 19 Jun 2026 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859410;
	bh=R85nORmp5ELhzrUmUj+jCgDNjc6ZJ4Ods7KPc7kZkxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ckzMoOMghfce9PQtNHcceceR4dcviduK0rbZo0aP4NRSjZXOK9Y9u8VuG4W8gaXvY
	 F38ummH/QN+Ucr8QW1so4kVTpC9MjixR+vkTLgL8uHOb/xwbPN+hZQsq4qKV4XjMC7
	 5ZBB2CS/N6a50GcJ3JqrWh+9Hdbez5Yd+g9cT94AX6q5ReohitU/zQinXGPQ/2bXCP
	 Q4Qtwe4m3aJptQQVca0FAaj5ZokEd/jMZ7+KVB+txVdGMi3p2Gr6jvx2gKPjJJvIji
	 7LR6xurJynNn5mJkGPZYsvc3Y+sTeqGf2FZuFr8Q9OD+zRadXs7x2YPlbhyQHSxV5V
	 PreOFJHLV9AgQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, 
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260618143922.3066874-1-michael.bommarito@gmail.com>
References: <20260618143922.3066874-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH v2] minix: avoid overflow in bitmap block count
 calculation
Message-Id: <178185940505.203814.7916120134365269864.b4-ty@b4>
Date: Fri, 19 Jun 2026 10:56:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-aeb64
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=brauner@kernel.org;
 h=from:subject:message-id; bh=axCAdIFEQxkQuujOYdiR30C5OZXhOTjQuJDwDicysOc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSZsgTsi3ocpf31uuk25ZZDKxexs/Y4cbzfWGXQynBUQ
 djMcKZPRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEW6Gf6nZnlc6wjf/pOV70mn
 2YvcUyyqR5Nv/n1y16Mm1iCzfocQw/+C+nXTjh02Vw11KP74MPnJZN1VfPdkkiwPV36Wnbxwjis
 LAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 18 Jun 2026 10:39:22 -0400, Michael Bommarito wrote:
> minix: avoid overflow in bitmap block count calculation

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

[1/1] minix: avoid overflow in bitmap block count calculation
      https://git.kernel.org/vfs/vfs/c/b6aa70f99629

