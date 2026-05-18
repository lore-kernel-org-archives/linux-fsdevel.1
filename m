Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139C3E2769;
	Mon, 18 May 2026 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085352; cv=none; b=J9ATk5/+o/eA5/JPLzFJ7AH/LMEb0upWNeCJIvwK9r2uqEQJUfDsPF4r9K6URr6K2ilKEfO5aWB8Ib/isPxMhK85aP2OlWXLGqOj4mXy7msCn+fddUU4fXM5KU96XBDMJJp3LIuby/w2EyRc7rQtw9gFNRlOWxy/j8Axa9FltKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085352; c=relaxed/simple;
	bh=zU7Ln2cwuApHTRf+nig0EHE/Ia30tFw3PHnmmBAPce8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWBrQHC8JN93jWKZw564VsZq0E3wjeZGgei5XdR9libQO3lWuVHgZ0hmUMHHpFg/U0oO2WfEKWkdSl1JDHO7dPGwwzC2oqTPubbG+TkBb4e0a/DSzcReHb6ZYRwwwmCKmrF8jt7Xw5mOabqGD81tqhNMyzrjXk6djyDt0S4/2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=qN69ukL4; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="qN69ukL4"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <janneke@gnu.org>)
	id 1wOrMd-0004lD-GT; Mon, 18 May 2026 02:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=yDbhPa2Ho+FjDBUMNwlLcEab30t5ml8asm6EXkzfelg=; b=qN69ukL4dr+BAdb9B8nL
	zNHI0r602ltONKY6zdz0cDxL8HJVXHbkJpah7SB41SHGselmiZzb/G9qWGifysDFz5/Ytq47s89Wb
	UL0dXe44O3c1QZalO6Q5DlVoK80UBoG8Fhff1Cb1Y1DMSYj0lc4FDXMYS3uK+m4+5menBhK/sEevn
	FmVhPcR5CAl1tIgDNKY2pT1GSyn1tpMancY7cUbxOkKRwm/xxQAwF5WaY2KtUGmlNFsc1GVwFwynT
	p2j7KF3HKWB7zRaQyyjvIhDY6A/lgNkK9uWHJmsTBfwmleqZmNATmTrMgR9pm2k+XMkjQE1XuGm4W
	gPm4ZJ7O12JvxA==;
From: Janneke Nieuwenhuizen <janneke@gnu.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Hugh Dickins
 <hughd@google.com>,  Ludovic =?utf-8?Q?Court=C3=A8s?= <ludo@gnu.org>,
  Rutger van Beusekom
 <rutger@reasonable-sourcery.coop>,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] shmem: support xattr gnu.* namespace for the Hurd
In-Reply-To: <d5cd1ce3-db3a-4053-8556-a52982ff4a16@linux.alibaba.com> (Baolin
	Wang's message of "Mon, 18 May 2026 11:54:03 +0800")
Organization: AvatarAcademy.nl
References: <87se7stpgy.fsf@gnu.org>
	<d5cd1ce3-db3a-4053-8556-a52982ff4a16@linux.alibaba.com>
X-Url: https://AvatarAcademy.nl
Date: Mon, 18 May 2026 08:22:02 +0200
Message-ID: <87jyt1ck51.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Baolin Wang writes:

Hi Baolin,

> On 5/16/26 3:58 AM, Janneke Nieuwenhuizen wrote:
>>  From d8291d06b67db045033664fb440f59001d7755a1 Mon Sep 17 00:00:00 2001
>> From: Janneke Nieuwenhuizen <janneke@gnu.org>
>> Date: Fri, 15 May 2026 10:12:30 +0200
>> Subject: [PATCH] shmem: support xattr gnu.* namespace for the Hurd
[..]
>> to setup a pipe translator, which is being used to create an
>> initial file-system image for the Hurd from GNU Guix[4].
>
> Please add your Singed-off-by tag.

Done; find a new version attached.

Greetings,
Janneke


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-shmem-support-xattr-gnu.-namespace-for-the-Hurd.patch

From 4ff8927bb044dab11fca9b258e7b9c0b221ac912 Mon Sep 17 00:00:00 2001
From: Janneke Nieuwenhuizen <janneke@gnu.org>
Date: Fri, 15 May 2026 10:12:30 +0200
Subject: [PATCH] shmem: support xattr gnu.* namespace for the Hurd

The Hurd gained[0] support for moving the translator and author
fields out of the inode and into the "gnu.*" xattr namespace.

In anticipation of that, an xattr INDEX was reserved[1].  The Hurd has
now been brought into compliance[2] with that, and so has ext4[3].

This patch adds support for reading and writing such attributes from
a Linux tmpfs; you can now do something like

    mkdir -p hurd-root
    mount -t tmpfs -o size=2M tmpfs hurd-root
    mkdir -p hurd-root/servers/socket
    touch hurd-root/servers/socket/1
    setfattr --name=gnu.translator --value='"/hurd/pflocal\0"' \
        hurd-root/servers/socket/1
    getfattr --name=gnu.translator hurd-root/servers/socket/1
    # file: 1
    gnu.translator="/hurd/pflocal"

to setup a pipe translator, which is being used to create an
initial file-system image for the Hurd from GNU Guix[4].

[0] https://summerofcode.withgoogle.com/projects/#5869799859027968
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3980bd3b406addb327d858aebd19e229ea340b9a
[2] https://git.savannah.gnu.org/cgit/hurd/hurd.git/commit/?id=a04c7bf83172faa7cb080fbe3b6c04a8415ca645
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=88ee9d571b6d8ed345f877e05f685814412e359b
[4] https://codeberg.org/guix/guix/pulls/8632

Signed-off-by: Janneke Nieuwenhuizen <janneke@gnu.org>
---
 mm/shmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3b5dc21b323c..5d60aa4dba92 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -15,6 +15,7 @@
  * Extended attribute support for tmpfs:
  * Copyright (c) 2004, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
  * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Copyright (C) 2026 Janneke Nieuwenhuizen <janneke@gnu.org>
  *
  * tiny-shmem:
  * Copyright (c) 2004, 2008 Matt Mackall <mpm@selenic.com>
@@ -4371,10 +4372,17 @@ static const struct xattr_handler shmem_user_xattr_handler = {
 	.set = shmem_xattr_handler_set,
 };
 
+static const struct xattr_handler shmem_hurd_xattr_handler = {
+	.prefix = XATTR_HURD_PREFIX,
+	.get = shmem_xattr_handler_get,
+	.set = shmem_xattr_handler_set,
+};
+
 static const struct xattr_handler * const shmem_xattr_handlers[] = {
 	&shmem_security_xattr_handler,
 	&shmem_trusted_xattr_handler,
 	&shmem_user_xattr_handler,
+	&shmem_hurd_xattr_handler,
 	NULL
 };
 
-- 
2.54.0


--=-=-=
Content-Type: text/plain


-- 
Reasonable | Free Software for Correctness | GNU Dezyne -- https://dezyne.org
+Sourcery+ | Correctness for Free Software | https://reasonable-sourcery.coop

--=-=-=--
