Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F53DDDDB
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139303; cv=none; b=VVHpwnyUXu32gnh4UIFPdyaAZ2J91Lvj8jxnBrbY1mzjCt4AKFEZiBInQl0vVQ88v30YQYoz79wyaYOVfd6fmcFMfOqyuq6W56qa7K/+9OuKLwjSntO486Pfzl0HS1w2x5D/ZM9UB+CSGlcJf2jPcRx1ycoi3JxgWyMAiba9avs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139303; c=relaxed/simple;
	bh=jG1VybOWP6wLaxCnTsPENDZb29h4/+iiudyoSVqH7b8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NcVIXbzTapHUeDA7t0Hbf2D7OVXN7Lp/lG78nsvZM8BNJegvaHRhy5QdXvWLgA1XmeplY5Wtf8lxXFSh0L/ScLG21SVHWrc7+yhDgygXLGmf0RCpc0k8pXWpsyX3JRSH1XvrfCtju6FAzRyKGzKXiTOxyRthPsYX2SUMpXIFcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ba/kuDdB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba/kuDdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785139300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pxe7RpMMYYPWZX2JNu88q4AXedb37JQOq+RTpKLIDQU=;
	b=Ba/kuDdBJ6gXQ6+cr6Cvvtmxedqn997biF5j0DgzGfjhG5U/+7eSi+61oP2SqUrRpICVRy
	UrDytQiBPO0mOV9LCGn1SSSPDzkykUFtRxfo/d/VciKZtNLAQG/BzvHjW7ZC/0worKyBoP
	Pq0x7Is4RB9ldi+4MZ0/GDnNMdtmAMw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-8rFxiEBcPcmCneZw1HcBwg-1; Mon,
 27 Jul 2026 04:01:38 -0400
X-MC-Unique: 8rFxiEBcPcmCneZw1HcBwg-1
X-Mimecast-MFC-AGG-ID: 8rFxiEBcPcmCneZw1HcBwg_1785139297
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E8F21955F3E;
	Mon, 27 Jul 2026 08:01:37 +0000 (UTC)
Received: from localhost (unknown [10.44.32.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66F7419560AB;
	Mon, 27 Jul 2026 08:01:35 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,  linux-erofs@lists.ozlabs.org,
  cyphar@cyphar.com,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] erofs: accept source file descriptor via fsconfig
In-Reply-To: <95a5fc3a-4259-44a7-bb72-8ff35a49a26f@linux.alibaba.com> (Gao
	Xiang's message of "Fri, 24 Jul 2026 06:38:20 +0800")
References: <20260717134147.1602735-1-gscrivan@redhat.com>
	<20260722-notnagel-allemal-kampfsport-8fd4e4d98a15@brauner>
	<6d1ac697-d5f8-4952-ba68-27610f17bf3c@linux.alibaba.com>
	<20260723-wickeln-schindel-rotstift-d987d4e9c036@brauner>
	<95a5fc3a-4259-44a7-bb72-8ff35a49a26f@linux.alibaba.com>
Date: Mon, 27 Jul 2026 10:01:34 +0200
Message-ID: <87mrvckgip.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> Hi Christian,
>
> On 2026/7/23 22:46, Christian Brauner wrote:
>>> I'm not quite sure if I catched the point, I think Giuseppe's patch here
>>> tried to record `file` into `sbi->dif0.file` (which indicates the primary
>>> "device" later.)
>>>
>>> And if `sbi->dif0.file` is set up by erofs_fc_parse_source(),
>>> erofs_fc_get_tree() will just use `sbi->dif0.file` instead of
>>> `fc->source` according to this patch.
>> Oh, so you only do it for file-backed mounts. Do you only allow
>> regular
>> files or do you also support block devices with
>> CONFIG_EROFS_FS_BACKED_BY_FILE?
>
> Block devices with CONFIG_EROFS_FS_BACKED_BY_FILE are supported,
> but with only `fc->source` (not this way.)
>
> That is the limitation I see in Giuseppe's patch. I'd hoped
> bdev-backed mounts could work the same way, but that would require
> changes to the VFS flow.
>
> Since this is a side improvement, I think it's fine as long as
> it's documented somewhere, and I do hope Giuseppe can at least
> address the documentation.

would something like the following be enough?

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 4230884fb359..768e1d43dfcc 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -139,6 +139,29 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
                        page cache.
 ===================    =========================================================
 
+File-backed mounts
+==================
+
+When ``CONFIG_EROFS_FS_BACKED_BY_FILE`` is enabled, EROFS can mount filesystem
+images stored as regular files directly, without requiring a loopback block
+device.  The source can be specified either by path or by passing an
+already-opened file descriptor via ``fsconfig(fd, FSCONFIG_SET_FD, "source",
+NULL, source_fd)``.  Only regular files are accepted; block devices must use
+the standard block device mount path.
+
+The backing file content must remain stable for the lifetime of the mount.
+EROFS never writes to it, but concurrent modifications by other processes lead
+to undefined behavior.
+
+Ioctls
+======
+
+``EROFS_IOC_GET_SOURCE_FD``
+  Return a read-only file descriptor (``O_CLOEXEC``) for the backing file of a
+  file-backed mount.  Returns ``-ENOENT`` on block-device-backed mounts.
+  Requires ``CAP_SYS_ADMIN`` in the initial user namespace (returns ``-EPERM``
+  otherwise).
+
 Sysfs Entries
 =============
 
Regards,
Giuseppe


> I'd also like to make sure the way fc->source is filled
> out of fd passing follows common practice, so that if fd-based
> bdev-backed mounts land in the VFS later, they can keep
> the same fc->source convention, otherwise it will cause
> a userspace behavior change.
>
>> Do you document the expected behavior for the file you're consuming?
>> Meaning, are concurrent modifications supported and what type of
>> behavior does this exhibit?
>
>
> As I perhaps mentioned, EROFS itself (or many EROFS) won't do any
> modification to the underlayfs bdev or files by design so the
> standard behavior is the blob devices / files won't get any change.
> Beyond that, both the on-disk format and the implementation are
> designed to tolerate unexpected external modifications (or storage
> media damage). Even in the worst case, where the underlying storage
> (block device or backing filesystem) is malicious, corrupted on-disk
> (meta)data will not lead to the kind of complex, hard-to-resolve
> inconsistencies you see in general-purpose writable filesystems,
> whose ondisk/in-memory cached metadata is much harder to reconcile.
>
> I'm not sure whether you'll agree, but I want to emphasize that
> again this is one of EROFS core design goals: the on-disk and
> implementation design ensure that. If there is any human bug, it
> will be addressed and fixed as long as it discloses: it won't be
> hard to fixed.
>
> But if you really want to avoid concurrent modifications or keep
> the image golden, I think dmverity or fsverify should be enforced
> to ensure the filesystem won't be modified unexpectedly or expectedly.
>
>> 
>>> The reason why `fc->source` is set was discussed in the
>>> thread of the previous version suggested by Aleksa.
>>>
>>>>
>>>> If they close it before this means you can mount something completely
>>>> different. The other thing is even if they keep the fd open someone
>>>> could just rename the damn thing and fc->source ends up pointing
>>>> somwhere completely different. The could switch namespaces as well in
>>>> some circumstances and then it points again into wherever.
>>>>
>>>> I've played with that fd idea before. The only way to make this work
>>>> correctly is if you plumb this down into get_tree_nodev()
>>>
>>> fc->source in this case has no use in erofs_fc_get_tree() (`fc->source`
>>> is just used for mountinfo for example), `sbi->dif0.file` works instead
>>> I hope I don't misunderstand something.
>> No, I misunderstood this.
>
> Thanks,
> Gao Xiang

