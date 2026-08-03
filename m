Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD062DB7B4
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758509; cv=none; b=cYcB+DxbI+SwFDZbELqxv8HgxC+U6ZOo25uN3qp5vcl/GZibcF/504VoNPyVzZrVrrHKjBk9Rb+8ZJ8pDByjqcGTHcS79z8Md2kq9KHC+hG2kP1MnINPnaLXyV9+Q0+0scmSzxSdm/nQFZDvpeSSrCLhJVc5M9j1yCRTB86uh0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758509; c=relaxed/simple;
	bh=WDmXhp7paIh1v4y355YOOlSkVY7rrPGF7dNjwNW+d24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYknx8q3vYC5VThxezzhM6Pb/uUYml9++njq5mHg5bp4dv1Pgp+D+3wXA4H+lanzXt4HqrVz7upooiC8s8UL9BwLcM2Tlr/nZ7z8qmQREoD1r/JElwGD0v4NXmanYkd58hYt+8+hgBSVg2qh1ClJGDPi0CvzXlFcbsa3WnLpz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVl7/YXw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVl7/YXw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785758506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/l/ULtq0dKzIiFBcjVXKrCzKILrVUjC7kgmZD3ajxI=;
	b=IVl7/YXwjtVVuVvPDSUgb6rJ5JvBMA4Mb7WKHubXUXtNavpy5ykLC5MucXMasOyZ26EPfW
	SgHvTw/efGrWCVaM4ptv4FsIVPmHmAmSk8lT8BexAysAY+IEXhyVTr5Ux875ZyJ1pT5FOM
	1JSPWZGdi7a5/tPwFATSuiiDh0DWc6o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-kulaAthoOQyfvVIq5lRYBg-1; Mon,
 03 Aug 2026 08:01:44 -0400
X-MC-Unique: kulaAthoOQyfvVIq5lRYBg-1
X-Mimecast-MFC-AGG-ID: kulaAthoOQyfvVIq5lRYBg_1785758503
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 551461954B19;
	Mon,  3 Aug 2026 12:01:43 +0000 (UTC)
Received: from localhost (unknown [10.44.33.95])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75CE7424;
	Mon,  3 Aug 2026 12:01:42 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org,  cyphar@cyphar.com,
  hsiangkao@linux.alibaba.com,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] erofs: accept source file descriptor via fsconfig
In-Reply-To: <366a9c6b-ec56-4cdf-b373-22a3cd8c9beb@kernel.org> (Chao Yu's
	message of "Mon, 3 Aug 2026 19:24:07 +0800")
References: <20260728160619.853924-1-gscrivan@redhat.com>
	<366a9c6b-ec56-4cdf-b373-22a3cd8c9beb@kernel.org>
Date: Mon, 03 Aug 2026 14:01:41 +0200
Message-ID: <874ihbxviy.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Chao Yu <chao@kernel.org> writes:

> On 7/29/26 00:05, Giuseppe Scrivano wrote:
>> Allow userspace to pass an already-opened file descriptor as the mount
>> source instead of a path string.  This is useful for tools that already
>> hold an fd to the image, such as composefs reusing an existing erofs
>> backing file.
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> ---
>> v4: https://lore.kernel.org/linux-fsdevel/20260717134147.1602735-1-gscrivan@redhat.com/
>> v3: https://lore.kernel.org/linux-fsdevel/20260714154917.489993-1-gscrivan@redhat.com/
>> v2: https://lore.kernel.org/linux-fsdevel/20260711071137.4130824-1-gscrivan@redhat.com/
>> v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/
>>   Documentation/filesystems/erofs.rst | 15 ++++++
>>   fs/erofs/super.c                    | 73 ++++++++++++++++++++++++-----
>>   2 files changed, 77 insertions(+), 11 deletions(-)
>> diff --git a/Documentation/filesystems/erofs.rst
>> b/Documentation/filesystems/erofs.rst
>> index 4230884fb359..774e8b236d09 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -139,6 +139,21 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
>>                          page cache.
>>   ===================    =========================================================
>>   +File-backed mounts
>> +==================
>> +
>> +When CONFIG_EROFS_FS_BACKED_BY_FILE is enabled, EROFS file-backed images
>> +can be mounted directly without a loopback block device.  The backing file
>> +can be given either as a path, or as an already-opened file descriptor.
>> +
>> +When a file descriptor is used, the kernel resolves its path and records it
>> +so that /proc/mounts and similar interfaces can still report the mount
>> +source.
>> +
>> +Only regular files are accepted as backing files; to mount an image that
>> +resides on a block device, use the traditional block device mount path
>> +instead.
>
> Do we need to add an entry to describe the new mount option source= in
> "Mount options" section in erofs.rst?
>
> Thanks,

I've another patch "erofs: reuse superblock for file-backed mounts" that
also touches erofs.rst and it is currently based on top of this version.
I wonder what is your preferred way to handle them.

Will maintainers deal with conflicts or do I need to submit them as a
single series?

Do you prefer a new submission v6 with the following fixup?

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index c972a869f3e9..49c4e7dbc5d6 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -137,6 +137,8 @@ fsoffset=%llu          Specify block-aligned filesystem offset for the primary d
 inode_share            Enable inode page sharing for this filesystem.  Inodes with
                        identical content within the same domain ID can share the
                        page cache.
+source=%s              (For file-backed mounts) Specify the backing image as a path
+                       or as an already-opened file descriptor.

Thanks,
Giuseppe

