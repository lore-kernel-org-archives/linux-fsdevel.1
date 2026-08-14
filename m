Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84516369D6F;
	Fri, 14 Aug 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696663; cv=pass; b=pImcEmikM5ZFkzyCBdgagAg/N7I8zrUOKMNNB6fshHQG1g1jgscFzV2xix5W7DLpmQJ09hsa37OpBJsuvcL7oOrsS7e0QolOJhYY/M1jEi+xEFSnnxXxb7Qj+O9lSiAjhIVAA2ubgRHrR85ijCymA2FOtoZEipQQfdoNeXDRqTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696663; c=relaxed/simple;
	bh=YQpzl80xF4ymPQA9ChelxCAAxIz1lvvOiNdAuf1JOSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGw8m1b65aSpwA8B3pkf62I3Pqbdafq7R2mKqG0XgDWIhIwpHaQRT2i6FCVxXrXowGyi7kYhxNzzYRC0VE+4gLAouooOQo9pKuf90VGO0CGFx+kHxh8nvDczj6DoexO3WaAbeghKRrLflYGPX465sDBZtPAech4pcdtKvIU6p8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=SZK9wcm8; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="SZK9wcm8"
ARC-Seal: i=1; a=rsa-sha256; t=1786696629; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=F0cjkvcsRVMx+3Du6Q4kGR+ao1oh6cpeqrZ33snM81tys343GCTWHOURmyO7fIcPO7aTgYNUy2zSjsz0TYpBiTRmgZUDG9vzDe3YX2z/pHDS7juaZK2vHkwSbwgvvvw98+BExcyMeIIzv8H8qZahG77hrUTF7ThNlb3nWz0EK/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786696629; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YQpzl80xF4ymPQA9ChelxCAAxIz1lvvOiNdAuf1JOSs=; 
	b=CzaMhYomD6bxFd4496tmWka2U+1cW1DstOqPLW4MS4watTbQFL6aM15iMuH6Wlic/wastvsEFK8utXx54m6ZHuWaiwBFv49nk4qAL1ZCLYQLmXkd4FlYvMSKXK54uHFJRNhqf05Oiqw0YVmgKedNOHiG8JlXbvuur+Q8duCSo+Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786696629;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YQpzl80xF4ymPQA9ChelxCAAxIz1lvvOiNdAuf1JOSs=;
	b=SZK9wcm8wtBvuXrZFtRpic+CsJRr0kEIJQOuXrJ9VDdId1ltRQDfpguuARtkvyWl
	bFyOGEJ23ezjJnYiT2DRUxt6ChDr98Q3gUADT7Dgzeh11oLVmh21onUsFA0oWoh1FxV
	hxk8STCeLmDHnBbZmJFccGnRcmhfpBzJnHNM8CL8=
Received: by mx.zoho.eu with SMTPS id 1786696626757971.813327235637;
	Fri, 14 Aug 2026 10:37:06 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: fs/ufs: three reviewed fixes looking for a tree
Date: Fri, 14 Aug 2026 08:36:53 +0000
Message-ID: <20260814083655.919447-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Christian,

I have three UFS fixes that Jan has reviewed, but they haven't been
picked up yet. I'm not quite sure which tree they should go through.

There isn't a separate MAINTAINERS entry for fs/ufs, and
get_maintainer.pl doesn't turn up much for files under it. I'm pinging
you since you've taken most of the recent UFS changes, but please let me
know if I should send these elsewhere.

ufs: create the root dentry after loading cylinder metadata
Cc: stable, Reviewed-by: Jan Kara
https://lore.kernel.org/all/20260801071306.59484-2-ali@iusegentoo.com/

ufs: validate cylinder group metadata before caching it
Cc: stable, Reviewed-by: Jan Kara
https://lore.kernel.org/all/20260801071306.59484-3-ali@iusegentoo.com/

ufs: do not treat unreadable directory blocks as empty
Reviewed-by: Jan Kara
https://lore.kernel.org/all/20260801013942.279992-1-ali@iusegentoo.com/

The first two fix a mount teardown NULL dereference and an out-of-bounds
access caused by on-disk cylinder group fields; both can be triggered by
a crafted filesystem image. The third fixes an rmdir case where an
unreadable directory block could cause a non-empty directory to be
treated as empty.

If useful, I can resend these as a small series with Jan's review tags
collected, or rebase them onto whichever tree you'd prefer.

I also have a larger series from Aug 1 that hasn't had any replies yet:

[PATCH 00/10] ufs: correctness fixes for valid on-disk filesystems
https://lore.kernel.org/all/20260801225530.148386-1-ali@iusegentoo.com/

That series is a bit different from the three above: the issues show up
on valid FreeBSD filesystems rather than crafted images. It includes a
symlink case that can read past the end of the device and panic on
unlink, a tail relocation bug that can corrupt data on 64 KiB pages,
and missing enforcement of on-disk immutable and append-only flags.

It's a larger review job, which is why I kept it separate. No rush on
the series as a whole, but there are a few fairly serious bugs in there.

Thanks,
Ali
