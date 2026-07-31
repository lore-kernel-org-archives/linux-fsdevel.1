Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D64207A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504251; cv=none; b=JyESfU/DLKWbtNYI9My7FA/F7b7fEBA02wi2M6Us5DKoriTdoLTW0GjkCvXiAdgiw7trnAfZwdXmjmxOAnfVPp/BRnIPrbF8EPv8CL6Z54NQI65FiRwkISP08XrqSOSsF68MXjpYy0JLy56WQF24eUVVeOKArDdgeOW0P8QLtJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504251; c=relaxed/simple;
	bh=//ksFVWZpfR2y4uzlMGnBQlYvGTk503puMqpWWhiSIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HSKByy7sr0NClbpsIlN3JR4phiu7HHxzbzVL5T/TuczlgQQQ0RIRnp5z2C8Rlh47fld30tdr5Q/fLotRWpFApKYOMQKSEukMsn+ZQ79gapVPCP/j3ou9fInVxQc5b3ibIgv5qgaSnKFbux1vUUdW3PxS3tduk2RPWLZW7ckTnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8B9FMOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8B9FMOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC541F000E9;
	Fri, 31 Jul 2026 13:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504249;
	bh=NWoUHKPAYNO/tadjMaSoFAAaihiPGAPG11BVKCu57eI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=i8B9FMOiFXkut/EfxK3nJnvxUnC//IWf6WpPTD/vkNy1r7Bq+UkKWjtAARWbfL/42
	 DMBKMlXd8clg03+EdfB/qVActG4l/a9mSov7iqgOWyd0s8ROdUclYYmKa+Q2rF0nev
	 flkl4Hx0iaEi1CrZ98MIJtjSXz/cPc3aDHTk4OL/nAPYx8P762W6PdxWRXszqbDqN6
	 Un5+K5hZm/upIuDskEZ6xHE+/0tV5eG7tiLuokGJKyN6C58Vd0k1bKvnoTG595fLtz
	 aDZWbEScNNfx6HKcKDyl56FAFrlPVzKJbSywm0RwMNyb8GNTya9u5aPkNLRN7/e0SX
	 Q8nO4za7NUUUw==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: =?utf-8?q?Krzysztof_B=C5=82aszkowski?= <kb@sysmikro.com.pl>, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260729113643.2255419-2-hch@lst.de>
References: <20260729113643.2255419-2-hch@lst.de>
Subject: Re: [PATCH] freevxfs: remove the driver
Message-Id: <20260731-abneigung-tricksen-lenkt-0f0c5a407bf7@brauner>
Date: Fri, 31 Jul 2026 15:23:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=brauner@kernel.org;
 h=from:subject:message-id; bh=//ksFVWZpfR2y4uzlMGnBQlYvGTk503puMqpWWhiSIM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlLPzxpGLOw0jtSYvEFKuOBnocvtV2on6X7jLlrTVzj
 hYr3OsV6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIezvD/+oFgi7CrU+l9/Ic
 M1798Lz7Zwe5eIGoV5WrrjN+6RGwl2b4X/v+vI/Ukvd1VSefMzi7XzaMdatRvKG7cs4N8bOxq+s
 LOAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 29 Jul 2026 13:36:40 +0200, Christoph Hellwig wrote:
> freevxfs: remove the driver

Applied to the vfs-7.3.freevxfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.freevxfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.freevxfs

[1/1] freevxfs: remove the driver
      https://git.kernel.org/vfs/vfs/c/a3ed4fcd04b9

