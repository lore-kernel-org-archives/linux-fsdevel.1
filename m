Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BF34C80D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429881; cv=pass; b=aQokSAKeFQNl+0iOSkcMX5f/F7ILOVSm+J9+3O5XzBoyVOhaFKJzx9cKtnU0x13Ob41Tpv/GNg+1i4CfBgfH89dBK7DaakBgeCBjFkaqJE79dbzv+dAiqdHAFDLVHu4xJo74O4Usp2I3kwffQ+k6rtfO4FgIH2f0za0JhLN7QSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429881; c=relaxed/simple;
	bh=fC/uan4rX3inFfsncSFitcekyi4kXWLCiPnm/SCAVVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZ9NaBJYX69pnIMYfiWHsp3Hmg5UPtiw+snz0v0Q7wmjjsNszGLrghZ2y3HJPb7xMDciSn1Scl55frN5X02S09YPTYRo4ljpVzYHrdPF0CetH2qfr7OgWsIgIZe3BiPKWnsKdtwwHoK3ID6dUw0fUKnVmIqoBqyxBesamelurKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4ec+noo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4G+yN5D; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4ec+noo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4G+yN5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774429879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmvsQXtzuSu9Q8Jr3K2x2Gsrg0C8mhjQT/B1CvBhxZY=;
	b=W4ec+nooFAl9B+Cuw6CzA7/INY84af8nvaBT+a6yrA+yHe1odHEmTCC4b6YXCA5VK5FpED
	Z1hW8lPWNMHWik+EIlQ8oF66zf5OqYzgpKKk8Vbk/AMC/2xKF1rNC/LOpLHWIzs5INBjIO
	8DlAwhoepeZgFqkipIWrpe4uJoDC7xg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-q5Cx8_vXNxK6YU81BEUajA-1; Wed, 25 Mar 2026 05:11:18 -0400
X-MC-Unique: q5Cx8_vXNxK6YU81BEUajA-1
X-Mimecast-MFC-AGG-ID: q5Cx8_vXNxK6YU81BEUajA_1774429877
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9417a552d0so969370566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 02:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774429877; cv=none;
        d=google.com; s=arc-20240605;
        b=c4kQeN+Q+KgypFjy+ZMShBzPMr0duYu1DrQH83cP8KtL9m6ML0YPr1eSGs4uOhiZ1z
         GvaUKJ2BXmTPNG4VxMb0ffuYmnDT0At/H98dehzI8PBtjqymUwpUK7aEfPdmnGWMY5bi
         e9/vSQOQP0XXLR7/08CpfdI2vRzG25Da6N63hlabmyY/b9e017c7HcsuPKyIL2vvCfiP
         KKo4AvwT+lSoSr4218xDzUrG+HUdX1QlGL04dYe85+NjSehfguDAqKNBO/GHLcAQhDnZ
         t8bW3XMfJTCdxdSwja2oinvvsj1EIRINwDqP85BiceOW1C/UMnymFO7o6bZ7bRU50YBA
         2GiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hmvsQXtzuSu9Q8Jr3K2x2Gsrg0C8mhjQT/B1CvBhxZY=;
        fh=D3fGZEXHpP5dX5Bw7JodvjIib9+txZGUgA7rFTmOIWw=;
        b=HUCcec336otmQErHhz7eolH0aQ8kq5+X6juwpMDHZTs3wJ0TPB9VqdvERz4Wh66qym
         gUODSitZHlCcpzmsrp7qQNxLIe10I7auVU1VDREKMHQDPFsrQyU9uD9T4dfdxz8pKHXC
         K9uql9edIQOWvJzM1yIfgFlre7Tm6OvoUORmmyVk39USTzD4+NmIIk8hX1E48JJUOHM1
         BIrf/tCf7wMeqVMR3cDDCdyNYUzC6fLioGDo+3eJklwqGeXKyPyGfPfiCik7s/QaF+O1
         WYRvmnllW1MwVcvtKc8Fe4aw5qhUqc0Y47FPZdAYVnllfgYFZHQRrEWwyAG5vv8vpaG1
         Tr7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774429877; x=1775034677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmvsQXtzuSu9Q8Jr3K2x2Gsrg0C8mhjQT/B1CvBhxZY=;
        b=L4G+yN5Dmfw2j4/6OKnYeZT6xAYWBOqaaTxBXEy210oTwMpfr9eJZG7dUHtY9bzIiZ
         mZfkYZ9hxRalJdMNYfegIQPcQvkXKq+Aq/Vpyizh12kHsVL9CDrPlq+aYwDJUvZJOmhm
         kSPXdcoY2I1LwWReAlhDe/m3J9Vtof0TIpuWs/CcCWVzARuIkidJEfxxXQJRmc8laIvd
         yY9EPcVT3i6aWi/gyGggh/0eZ1a41C6/ZZro8sFhzZcd817ZEd9hrqpeCQ3nlLBlk9BJ
         IwHe2Em1bd8VddylQpKwYdMxH2QVQDZNfGFcAvhHCIz0l8D+qgA0yhkFpte8zO0TdSnE
         lDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429877; x=1775034677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hmvsQXtzuSu9Q8Jr3K2x2Gsrg0C8mhjQT/B1CvBhxZY=;
        b=SM4FVsm5HhHRN/4KP8xDPPLB5V6J3qETEAbe+eDAUnYZadN4n7wqwcifG2D5J8abTB
         FyBvzBxxiAg1ESOwIl8tipaNmkeVEfS0KDUNvsy0z2QE4+ebbQW/5G2wkmU/j9pzi8py
         E6XjhEr2BgnzZKeIICbzV/AD1GN3PcM6bfHJh+cD/GNgUau5z3gfu9FVnJC7Kgq7lr7T
         62iyeWEqhK8I+q3XHTMa1UXOF1UdFAmt831uInRgYaTXJWC7r5DWI/SVMgFWtAD5pC05
         j8fHTiexb6qjdOiIWokDgDVo8lKUNtGFuSuqYGgksALJDAk+6GGlHIFrqOubefOUix6g
         EwvA==
X-Forwarded-Encrypted: i=1; AJvYcCVuxTc09lkGmJNgjX5UvECs3B6z9Ix7uKNQjia1ePATQUASjL8Pn9Nmqd3ZCuL50DM2VwCMgl+1gYSZA0He@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzOfZfUeh4sn6ZrWYijzkDXNnEVwYwzNV9qCwocCePoPRoK6j
	I1ybR2mxXWwo2rG0awRR/NApcnXkqQEaTHlnWZze1C5FleWzMVapTb8V/u1PUMrao+m9R3rx0Tp
	SMjL1qROoIFNogjSxkF8k6L5p/nyUZb10al92n7zB7emVW9pKiAExzday7N8JMFQ/ziVT4mGXrJ
	Z0XOU+QjNdWDniX9/8kBM/iqSir0f4333aH14Yml2eVw==
X-Gm-Gg: ATEYQzwSeEyDOKr4FLuVk3Y4BdrVSGcNpplV5TKiTv/Cw/AXVL7Tz3TfmLj2d3ObMhZ
	/lPxSKordZ6sSTDq/NhOPcyeejZEvnCILv1+0OxE0Hr6uwgStc8X7EeMaVXVSMYZg1lkkM2KpRB
	4N71L5hq3bDNpjRuWMnoslehEvqKNhnRsVMWPZPj9MXBG20s2dSA3DoY6/LRGUEkfN8ewBTeH9j
	20oqyFx
X-Received: by 2002:a17:906:9f8c:b0:b96:f9c9:9d2b with SMTP id a640c23a62f3a-b9a3f175fa8mr182597266b.8.1774429876552;
        Wed, 25 Mar 2026 02:11:16 -0700 (PDT)
X-Received: by 2002:a17:906:9f8c:b0:b96:f9c9:9d2b with SMTP id
 a640c23a62f3a-b9a3f175fa8mr182594866b.8.1774429875909; Wed, 25 Mar 2026
 02:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312090810.1145908-1-ravising@redhat.com> <20260317065947.306954-1-ravising@redhat.com>
 <jknk6pwirqp5kgxdwr7qez2qzuycmj4eupknf3yvqzlnkyiu5k@nowg6cwpxqc3>
 <20260317133159.GA53921@macsyma-wired.lan> <ijwjh525hgf54wclhd4oixvfi3gfrodqrh2pbk7lr3whqw7nqo@k5uotrmekwyt>
 <20260318221810.GM1742010@frogsfrogsfrogs> <waksu55vh2fm74ltktchuckhezkjq4ggaooqrosixfzsuli5uo@i4q6ixu7r56x>
 <CAF-d4OvGmXWRinOB_qQYbCX9pckGLQbu1pghqDm-LhzHOaQY6Q@mail.gmail.com> <20260325001621.GD6202@frogsfrogsfrogs>
In-Reply-To: <20260325001621.GD6202@frogsfrogsfrogs>
From: Ravi Singh <ravising@redhat.com>
Date: Wed, 25 Mar 2026 14:41:04 +0530
X-Gm-Features: AQROBzC8tgx3qd4si6PDAOTlzXEzyAPXs8WmE2qMsH4v5rPfZkMUDH8EqM9CWmY
Message-ID: <CAF-d4Otft7-QYWJCRzgD3xKRqXdSMSTyuKebpLP_hNgJctsAkA@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: return default quota limits for IDs without a dquot
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, adilger@dilger.ca, jack@suse.com, 
	cem@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 5:46=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Mar 23, 2026 at 04:55:31PM +0530, Ravi Singh wrote:
> > Hi all,
> >
> > Thanks for the feedback. Before posting a v3, I wanted to share some
> > additional findings. The v2 patch only covers one of three scenarios
> > where an unprivileged user cannot see the default limits applying to th=
em.
> >
> > Scenario 1: No dquot on disk (v2 fixes this):
> > xfs_qm_dqget() returns -ENOENT, and v2 catches it.
> >
> > mkfs.xfs /dev/vde -f
> > mount -o quota /dev/vde /mnt/test
> > xfs_quota -xc 'limit -u bsoft=3D10m bhard=3D20m 0' /mnt/test
> > # Do NOT chown anything to testuser8 - no dquot exists
> > su - testuser8 -c "xfs_quota -c 'quota -ub' /mnt/test/"
> >
> > Without fix: empty output
> > With fix:
> > Disk quotas for User testuser8 (1003)
> > Filesystem              Blocks      Quota      Limit  Warn/Time      Mo=
unted on
> >  /dev/vde                     0      10240      20480   00 [--------] /=
mnt/test
>
> Hmm, yes, that looks like a bug to me.

Thanks for confirming.

>
> > Scenario 2: dquot exists with non-zero counts but zero limits (v2 does =
NOT fix):
> >
> > A dquot is created for testuser8 before default limits are configured.
> > When the chown runs, xfs_qm_adjust_dqlimits() is called in
> > xfs_trans_apply_dquot_deltas(), but the defaults are all zero at that
> > point so nothing is pushed into the dquot. When the admin later sets
> > limits on ID 0, testuser8's existing dquot is not retroactively updated=
.
> > xfs_qm_dqget() succeeds and XFS_IS_DQUOT_UNINITIALIZED is
> > false (q_ino.count !=3D 0), so xfs_qm_scall_getquota_fill_qc() returns
> > the dquot's zero limits.
>
> I think this is a difference in opinion -- the last time I checked, the
> default limits are only supposed to be propagated to newly allocated
> ondisk dquots.

Understood: Scenario 2 is by design.

>
> It's true that it would make more sense if the ondisk dquot had a flag
> to say "I've had limits applied here" such that default limits would
> apply to a dquot that already existed on disk but hadn't had limits set.
> Plus then you could modify a dquot with explicit limits to revert back
> to the defaults.
>
> Unfortunately there's no such flag in the ondisk format so we'd have to
> rev the disk format to add that behavior.  As such ... I don't think
> this is easily fixable.  The only way you could revert to defaults is
> if...
>
> > mkfs.xfs /dev/vde -f
> > mount -o quota /dev/vde /mnt/test
> > mkdir /mnt/test/testuser8
> > chown testuser8:testuser8 /mnt/test/testuser8
> > xfs_quota -xc 'limit -u bsoft=3D10m bhard=3D20m 0' /mnt/test
> > su - testuser8 -c "xfs_quota -c 'quota -ub' /mnt/test/"
> > # empty output
> >
> > Scenario 3 : dquot all zeros / XFS_IS_DQUOT_UNINITIALIZED (v2 does NOT =
fix):
> >
> > A dquot record persists on disk with all zero fields after ownership
> > is transferred away. xfs_qm_dqget() succeeds, but XFS_IS_DQUOT_UNINITIA=
LIZED
> > returns true and the query returns -ENOENT. The v2 fallback does not
> > trigger because it only handles the xfs_qm_dqget() error path.
>
> ...you delete all usage for the dquot and set the limits to zero, right?
> Or does setting the limits to zero actually work even if there's quota
> usage?

Setting limits to zero alone isn't enough. XFS_IS_DQUOT_UNINITIALIZED
checks both limits and counts (q_blk.count, q_rtb.count, q_ino.count),
so all of them must be zero. In the reproduction, the chown back to
root moves the inode count back to 0, that's what makes all fields zero.
If the user still owns any files, q_ino.count would be non-zero
and the dquot would not be considered uninitialized.

>
> Either way if the ondisk dquot is totally uninitialized then I don't
> think we need to emit a record unless there's also a default limit.
>
> > mkfs.xfs /dev/vde -f
> > mount -o quota /dev/vde /mnt/test
> > mkdir /mnt/test/testuser8
> > chown testuser8:testuser8 /mnt/test/testuser8
> > chown root:root /mnt/test/testuser8
> > xfs_quota -xc 'limit -u bsoft=3D10m bhard=3D20m 0' /mnt/test
> > su - testuser8 -c "xfs_quota -c 'quota -ub' /mnt/test/"
> > # empty output
> >
> > I see two approaches for v3 and would appreciate guidance:
> >
> > 1. Fix all three in xfs_qm_scall_getquota() by merging default limits
> >     into the response for any zero-valued limit field, mirroring
> >     xfs_qm_adjust_dqlimits().
> > 2.  Expose default limits through Q_XGETQSTATV using the available
> >      padding space in fs_quota_statv, as Jan suggested, and let
> >      userspace tools merge them.
> >
> > Thoughts?
>
> I don't think we should create more userspace abi since nobody seems to
> think that anyone uses quota limit reporting aggressively.  But if
> anyone does, now would be a good time to say something.

Agreed. Thanks for the feedback!

>
> --D
>
> > Thanks,
> > Ravi
> >
> >
>

