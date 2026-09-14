Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A942589C;
	Mon, 14 Sep 2026 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378515; cv=none; b=MHl4YO9HdKvnXWtI5q1iOOQvk5/5A4XD0f58ZiHT9h8BTzVVYiVCXUjFBfVLv34I1K6DWtGUhK6KXUZ2NeubaZaC5HYku5oOtIcT7fotK0eOwqY4IQzOwaca8YnWm5pMTVnP01/+ZSk/P4/eNcy6reABRuhv4wxmVnIh7o0DwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378515; c=relaxed/simple;
	bh=kZfEzUE9D0r+jPRhZX1xxJv2TfU8XecSNnAfY+u4lLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tCcdIYRfFrMnRA009doAWKWouBNo/3pja6B5PYd+zdD0ocE/EjOfp3oklduQcUc+n5MXX61lXRD00qVf67CSa9hozz70WaeAnkaSwkR8nLY6qIxpiq3t0ICallMJVJXyXenzsRoER7HbgxIWbBmoxvQCIDWFaHi3hoPGo6hUC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=mC6R6vj1; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="mC6R6vj1"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D32F914C2D6;
	Mon, 14 Sep 2026 11:34:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789378500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FQj/UbNv+AUtLk8gb9YNWkGybW6AtBdWo1xqClNzlgc=;
	b=mC6R6vj1D7TLKo/Elv/ZqQw+iJHQ9uJJYlOd+e8w24XXlW9foPv8FSVDH30aDw+zqSg3MA
	sFxZjHzOHq/kBEi3ajgZgURHs+E3XOL+DIFt9bfT9D6YXfq0T7TYuoeDV3BxmgU9GU6paZ
	In+iVkb0L22FAmxcDXNtLicbAwVxYsCdFFE3iDc+n8PIJcU3RsA69KMyEGTSC5h7mqduWE
	+jLMw22Usc5IieCUH9OCrl1qUitTFMFuYVKJtHtUKc3mhSMzaAqa+2HsM5TSVlcHUqAxrZ
	2Gm9vvt54Yk+M32KeIQ+eoPylPzcTx2LYTHb2RuDnSFLp6zsvZnlQS0pam5JIg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2a36b916;
	Mon, 14 Sep 2026 09:34:55 +0000 (UTC)
Date: Mon, 14 Sep 2026 18:34:40 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Mulqueen <mike@method-b.uk>, ericvh@kernel.org,
	lucho@ionkov.net, dhowells@redhat.com, pc@manguebit.org,
	linux_oss@crudebyte.com, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p regression fix for 7.3-rc4
Message-ID: <aqe_sF0kM6mGn_KY@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-7.3-rc4

for you to fetch changes up to c60ae98c5aa64021751b38ab1313b19d620bf640:

  9p: Fix v9fs_issue_write() to update i_size and remote_i_size (2026-09-12 07:49:22 +0000)

----------------------------------------------------------------
This is a single fix for a 9p/netfs regression that got in 7.1
(and was backported to 7.0)

We need to rework how cached attributes, and in particular i_size, are
handled in 9p more thoroughly but that will take more time and this
appears to be enough for the most obvious problems

----------------------------------------------------------------
David Howells (1):
      9p: Fix v9fs_issue_write() to update i_size and remote_i_size

 fs/9p/vfs_addr.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)
-- 
Dominique Martinet | Asmadeus
