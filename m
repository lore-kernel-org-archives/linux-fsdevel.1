Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A23E92A9;
	Tue,  7 Jul 2026 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421492; cv=none; b=tJAjpx4/KfJI8uwsIotbroNabVzekyxXQq5d2nbAWAiQxA8Vz3bm0joq9sgJCwmGdU5MvcsKZ3EdyHSrtNDn68b2+qbNJARHwEEaWL6ngcDRAUWhTXQrRQ+Az/3GyjFdhXttsTEk2VNIvSQ7f0uu5/nWHQ6lglpHRV00yAP7YM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421492; c=relaxed/simple;
	bh=l7blwHWSro9yb0JCARbYGND7M67aUutBuqI/wvIQmXc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NGmtxe8/lGoU1SV799dpQlIKMNpZ3e8swgAqEMPLm5/uwyNaT8QcBe/rUFj/gTZ6/mlEzrYt02evIXHTWVwcykNTPL8cYXQKTOdJqIF+tLtOOJquXz2MwMgUchXIoHE/+Xclq2/8c08QkUYW6t76gvY9vqaL5MffmD/7xFCKJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilTuBiJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilTuBiJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA21C1F000E9;
	Tue,  7 Jul 2026 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421491;
	bh=2VPwyJdACuWrDEmnXy+N/+QMonkk1QedWeM/tRVPlFc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ilTuBiJwfs0gc2X+Nyajg0q8xx8UNJikFfG9oadEz/REEWM1elt6e4t7hPioA8010
	 PFzxFjOi9PmKnnd6enxg3nJX2sYvK0SQpB0vOb2a+zezIRNJcn/VSnuIlUNKYYKhdp
	 2KCwUuBROOoPZKSHKlS/lX/23dk6KDK6lAYfn1pAFhpAHMDed6LS/RiaBAwzm7V7xt
	 Zi8dYR3VgoWmUPAN56tfx9iNud11W7nC/RTeFoz5GBDBwc5a2udmZ/0PuZ8pZ9FuiG
	 GRlHzSq1g71KN88cDhITWcBJFUawJAM6ihH57e9xl6YzyKNIqK+xfSZdiSiGncus7R
	 3QFBoT6Eux+cg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 00/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:22 +0200
Message-Id: <20260707-wimpel-sparbuch-erworben-28cb064256d3@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l7blwHWSro9yb0JCARbYGND7M67aUutBuqI/wvIQmXc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53NKPLuX3FAyOWiQtn/v9rP6HzJ0vJY5d3Sv9lcVMx
 v6D0CzbjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8+sfwTznyLc/80+WHSlzm
 82QL3E54rzYptudQ9mKxuTG10rKz9zMyrNZKCn/rrL7rD+ezojMSRz9+mae+omrVyQecjAI/217
 OYAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> This series implements new semantics for the O_CREAT|O_DIRECTORY flag
> combination for open*(2): perform a mkdir and open the resulting
> directory; return a pinning fd (which mkdir does not).
> 
> Most of the work happens in "vfs: add O_CREAT|O_DIRECTORY to open*(2),"
> as may be expected. Before that there is some clean-up work and
> preparation. Also, the inconsistency in calling audit_inode_child() in
> lookup_open() versus vfs_create() path is addressed. The
> "vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens" patch is
> also worth paying extra attention to as it short-circuits doomed opening
> of directories as writable. This check for regular files is now done
> very late in do_open(), but for O_CREAT|O_DIRECTORY this is unacceptable
> as this would create the directory and then still fail.

Please make sure that the series doesn't contain unrelated fixes.
Ideally just sent them as standalone cleanups/fixes. If you move a bunch
of code around to fix something else it makes it harder to keep track of
the actual changes that are required to make the feature work. That
should only be done if the fix is really small-ish. The
audit_inode_child() thing seems poised to cause a lot of churn and it
also requires some form of agreement what precisely should be audited.

That in turn means you need to get audit people involved. That means you
making your series harder to merge as a side-effect.

-- 
Christian Brauner <brauner@kernel.org>
