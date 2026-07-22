Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D534A3D9;
	Wed, 22 Jul 2026 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731266; cv=none; b=DlxOHJRVfh+fSWKXJZCt/+Uwb1rqjz2OxH9ipOTJuN622CqrVavSLGDW99j5xF2ncrtvh6/CnAcibiXzuTC16mYxrucQs/e6aBQSgfMKwpIrFXiv3cFUrLDpUShqnB7bFHE+ZDu9aiLpY9hl8DCcVkdNQ+lxivV3guHFya4rXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731266; c=relaxed/simple;
	bh=r7HEopcqZQVCsuyPTjY2Df8a46NkzdYDZO4mEueFl5g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KY8/SFzIF7m2BDRyQX4A1zI7RvOjK9OLeW2NkFViOsdmtzNTfdMwMMvkpd96N7wHFKy0CrHjTSqI/CqZAyS4JMIYnCTX9DEYphTOaKe+yvGgA6F4vBbTHAhE9iXKb/t3g+ha4MP7ZzR8O+RKpuFDUzbNPp47ZT7Ze8dsobfaCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDMjNdhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDMjNdhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAEF1F00A3A;
	Wed, 22 Jul 2026 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731265;
	bh=n/Co1BRUJxV8Ilnz0HmcLKDLBLt1Hht56jIYYXO45Kk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=PDMjNdhmsMNcnFmbElhJiWIRqgRYRP33iz5wRRgYMFiRcjIZoxHWNLmK7xLZHhUw1
	 on1roFgC7Q0NkdC9vylVxx6/RA1q3B/jMzfP0+/MKbL3/ivN42rvqTxnjvLmwqD2uX
	 EigvSr7T2p9lgPPzOTqYZkOcgi8AnvgjWFUe8x1fPdzLaIFzA6bde9FLXelI7lI70w
	 boSNSuH9BTMzJdJLHuEkpjojnpdhxB2IZZluBWrzdc9eJ8Vq24UhNjOCOhnALM7Sqx
	 iPZAiEZe7dsYQkgbhl2/fRznG8NR5uk53EFrnsfIKCebCNzarK4AUR5w8zOo7IZBhJ
	 sLWcd+9IvXx8A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] vfs: call audit_inode_child() in lookup_open() on
 failure
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Eric Paris <eparis@redhat.com>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, 
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260710164233.827744-1-jkoolstra@xs4all.nl>
References: <20260710164233.827744-1-jkoolstra@xs4all.nl>
Date: Wed, 22 Jul 2026 16:40:59 +0200
Message-Id: <20260722-semester-unerlaubt-raubkatze-aa55ce95f36d@brauner>
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r7HEopcqZQVCsuyPTjY2Df8a46NkzdYDZO4mEueFl5g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlXKs7bBbnx2vGOLt41fsf8f4zbYPbp8aUZKQe7M0V2
 DEzfXd5RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER01zIyTNDotlpQ01oq+G7D
 +om7WqR2rbviJOtcq8x2oHvDhthbAYwMd7t8DFx2H7Kc0bj1xEWVssAWNqFfWy9o7dk8KeHJyfQ
 SVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> While reworking lookup_open() to implement O_CREAT|O_DIRECTORY I came
> across inconsistency in how audit_inode_child() is called in various
> file create paths.
> 
> audit_inode_child() is called in may_create_dentry() so that failed
> filesystem operations still register an audit entry. On success, the
> entry is overwritten when, for instance, fsnotify_create() is called.
> This is the calling convention in vfs_create() and vfs_mkdir().
> In lookup_open(), however, when atomic_open() should have created a
> file but didn't, no call to audit_inode_child() is made. The same is
> true for the regular ->create() path.
> 
> On the suggestion of Brauner, I am splitting this series from the
> O_CREAT|O_DIRECTORY work, so that this can be discussed with the audit
> people without delaying that work.

Looks good to me. I'll wait for the audit people to look at it too.

-- 

