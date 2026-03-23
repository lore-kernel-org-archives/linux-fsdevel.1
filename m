Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A5396598
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265148; cv=pass; b=fAH9RDQERQC8zqLmSqY3seJ6BYv9UkCSWiExfexImpmCcCXIfZB2tKDvDzPM/YMsIcwQ5iPL2aXEP90xPBEwX3xLoDJsLHqdkdjYPQBjoV2ycznXsvmYySf3v4E/FFYgFLpCd/MwgbOOrXmmIfYc9r8OH/g9NTIYQst3aWnYq0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265148; c=relaxed/simple;
	bh=SgQG5ejgW1WxUybyAAM8rt7HZkPdDCIfGfpizpvccms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpUl2tGL7bAb+A3gafYlHf9MIDrbAB3WZ/eMT9Wn+MtMM2N+891r3uMLF9GV8vxZiiE7af+j9rFZxLJ6yWZMNpLuaTUGKoVB94oZ+gvMKEdA79h7iVkELl3+tTMUeb6Wh7/RRjm6/HV/cMeoHDBolbYHCcHOap53BfKz922scKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXwyL2In; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXmo7PnH; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXwyL2In";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXmo7PnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774265146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67u/NLiGVOP5D7N4bIRzvnVB/KnTMtvWXarwYg+7w48=;
	b=GXwyL2InMZnJz//2fb+yGFyUyAZ0cW7xOpEzo4KtI7MwiAMTSKPIk/MSDdoaRw6zM5XahF
	ikw+fNd11dv6LmePrkTlNSPriv5ITBffOS0fA5kqbEpcXntx2LXsozKdEJIObkjYErRoy0
	L4GIKnHNk/kcKC+OmTejDE7smU/NqrI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-fGR77UqTO0yeVjXULxab-Q-1; Mon, 23 Mar 2026 07:25:45 -0400
X-MC-Unique: fGR77UqTO0yeVjXULxab-Q-1
X-Mimecast-MFC-AGG-ID: fGR77UqTO0yeVjXULxab-Q_1774265144
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8fbe7a6f41so4742166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 04:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774265143; cv=none;
        d=google.com; s=arc-20240605;
        b=PsXrN+spvamb/x16kB5CcyGAvAWrxjnWY6WtNutBeAHRk/oB0DlWx+NX3RMkpjbbCT
         acSnpuXJZYSITfotk0Q3PeZnLBI8oPytMmSl70mJJqhPXlEufo6UlACrE18h7PNPelfK
         ycyBtUgp3T2f1UXVBRq+6kJrmvjM2Xo0Vpu9hwsoucpzl+2sxz0hhJh2gF23dp4UulQn
         nSMFyNcLEE9tspAFg8jsDA65L1bV0OocAKQNyPYZJXc40HKsW3DV7SicCoIJeY3jarac
         o8fPwJsHqhd4iYsbIokXlY1ydnNZaIkZnqJQJE8S3+z5tSSYigQ5XGrjkBASqVRJXNYY
         eTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=67u/NLiGVOP5D7N4bIRzvnVB/KnTMtvWXarwYg+7w48=;
        fh=o9IfDyqSuKGYrG5uLOugW+mQzp316z2vbQbGSP/4oeM=;
        b=j55q7p6SONTlJx3qefxWTegW/X8VqHMzHVZ8++CFq76C6f2K/6R8wU6HHKNdHafxGt
         f+W9Jm1guLha7vWk/R+1R2ivJEHko80XHApDjW05xKzuSFQYKOQi1llZPHILpAYwuWKH
         JtUx/dQYHbckQ64WFpcDBT0s6ExdBV7IMTcGT2oDFCb24AwOWIKP+aRj77wkm2dyJOJ9
         E1StWrmlYTKhPPuUDqQb0SV5MdKu1Uk/BIqb+4ntJun62A5kUMuOGpT2IY65fi4g9LBu
         pYMTB3EWDn91WOAgjI2znilVwfHY4uSJOSI77hYbUuzoJrnVZQJP8lUdRR5QUQQgC5jp
         Z0SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774265143; x=1774869943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=67u/NLiGVOP5D7N4bIRzvnVB/KnTMtvWXarwYg+7w48=;
        b=LXmo7PnHEMM5Sp3++KA8QJtDwfmnTEOhbu6ueg0Mjp5eXyJhwG9OvT5GAm4iQhb81h
         jJhKD2gZ5gfPlSfrQTeh9D5gBHYltWaxz8Ht5wtrRypDzGHVAkAfMFJ6R4kBDW25EHVY
         4Ma0VEQSUipVGTjS80h/OAan+LIu3ReoKsdWrdPmAg5Dwm8bIMSHv2m3sMaIYmTyP+5h
         JUlbJW9+sIFjKkmx/Oojv4HLC6/qvqt44vqWhPom0kohELZE30bdmFBPLjSFPMCxHtzX
         UcM5jXdra5Q792YEdMpWaGBk3R85qUkJZ63CpEVxCfWwB6LRBVO+o6+78+fAL9k/WX17
         0FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774265143; x=1774869943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67u/NLiGVOP5D7N4bIRzvnVB/KnTMtvWXarwYg+7w48=;
        b=WoAN6WxE2Lqq7Hws+DyL5FAJaeX8tYdqEbXjFPp2txlgY4lJmeQOXZa0AgVbSCqIuu
         6LBo9h9SxziCkNGd5JXLnGJGFYZzJjVfwviu+NnolRMJljNXH20xjRZkuhuxSMyHLKN8
         6fckn8QZbLE/L8MKNYRCllex5H5bCOhVbMItDShG07tKc5//uWZvwoXbJ9Ah2lSTgfZB
         nSnbdhrTyAzMzYxVZCn7yO0lMIBXtIGTKN4tcKIwO8oE/a/oFDVp88V7l3hHcQlA5d5b
         B3PfkwFcjoBD1gUZwgJ5BmNFt6I/2b6nklvwfnlrmGsKPMvTVMGatvlo1x476o0Nib7C
         7IRA==
X-Forwarded-Encrypted: i=1; AJvYcCVpJiQ3YC7b3nnn8PBNnUw7a3GeXIObIC/JRCNUZRKFgwd9uiWFPGm7OsKkPNNOgIX5e0Oa4zbcHo3dhJmi@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtRkw5vXeRyFE4GPPa1JeBlg8p474gPMMbQe5luFGBCfIHmGF
	EMg/kiVEZ5AdD+PbF+qgWLKQTT6lPiU9ebPZoxW2UUE8yus8RZFuHcAUUbCZPA7zjm+dvZkrfVO
	jZPlFmJi7Ubxhx8eFpzjwKqbW7ylK2p3SPJCVwksQgTBg3oUfPK68fzSvM18HMSTLppg4VsT5FN
	hCIuEEjR0Tpe+tbvgmRAVDAOpO9UqIjNBFNXpM1S5GaA==
X-Gm-Gg: ATEYQzx70dFB6zrh7lxMO3e/YBNAXqKtsAWXSYyGw2P43JDHnwDkWuPH2jj+ya/dQqo
	MUKAFnmSN/EfQgl6uWO/D5HoiDZ+pGjCkX6uwNhX7grsstFyWcvIFOFBAL51+5XEJIDRM5wpMOV
	51SDTPQ4uZ6AEV50ubIqO3menRlvYkG5LhOG58ZEg+ifchz8aETRhoPq0vjr4rUqdzwxVoEmzMf
	6YbxOnw
X-Received: by 2002:a17:907:2d14:b0:b98:6c41:a77f with SMTP id a640c23a62f3a-b986c41b6bbmr251633866b.20.1774265143436;
        Mon, 23 Mar 2026 04:25:43 -0700 (PDT)
X-Received: by 2002:a17:907:2d14:b0:b98:6c41:a77f with SMTP id
 a640c23a62f3a-b986c41b6bbmr251630966b.20.1774265142881; Mon, 23 Mar 2026
 04:25:42 -0700 (PDT)
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
In-Reply-To: <waksu55vh2fm74ltktchuckhezkjq4ggaooqrosixfzsuli5uo@i4q6ixu7r56x>
From: Ravi Singh <ravising@redhat.com>
Date: Mon, 23 Mar 2026 16:55:31 +0530
X-Gm-Features: AQROBzDv_PXbd61Y_t8LXNzL7Rn5JZDsfsrrP-vHw5-ek6F4YVqT9iiVk_OZ2CM
Message-ID: <CAF-d4OvGmXWRinOB_qQYbCX9pckGLQbu1pghqDm-LhzHOaQY6Q@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: return default quota limits for IDs without a dquot
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Theodore Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, adilger@dilger.ca, jack@suse.com, 
	cem@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Thanks for the feedback. Before posting a v3, I wanted to share some
additional findings. The v2 patch only covers one of three scenarios
where an unprivileged user cannot see the default limits applying to them.

Scenario 1: No dquot on disk (v2 fixes this):
xfs_qm_dqget() returns -ENOENT, and v2 catches it.

mkfs.xfs /dev/vde -f
mount -o quota /dev/vde /mnt/test
xfs_quota -xc 'limit -u bsoft=10m bhard=20m 0' /mnt/test
# Do NOT chown anything to testuser8 - no dquot exists
su - testuser8 -c "xfs_quota -c 'quota -ub' /mnt/test/"

Without fix: empty output
With fix:
Disk quotas for User testuser8 (1003)
Filesystem              Blocks      Quota      Limit  Warn/Time      Mounted on
 /dev/vde                     0      10240      20480   00 [--------] /mnt/test

Scenario 2: dquot exists with non-zero counts but zero limits (v2 does NOT fix):

A dquot is created for testuser8 before default limits are configured.
When the chown runs, xfs_qm_adjust_dqlimits() is called in
xfs_trans_apply_dquot_deltas(), but the defaults are all zero at that
point so nothing is pushed into the dquot. When the admin later sets
limits on ID 0, testuser8's existing dquot is not retroactively updated.
xfs_qm_dqget() succeeds and XFS_IS_DQUOT_UNINITIALIZED is
false (q_ino.count != 0), so xfs_qm_scall_getquota_fill_qc() returns
the dquot's zero limits.

mkfs.xfs /dev/vde -f
mount -o quota /dev/vde /mnt/test
mkdir /mnt/test/testuser8
chown testuser8:testuser8 /mnt/test/testuser8
xfs_quota -xc 'limit -u bsoft=10m bhard=20m 0' /mnt/test
su - testuser8 -c "xfs_quota -c 'quota -ub' /mnt/test/"
# empty output

Scenario 3 : dquot all zeros / XFS_IS_DQUOT_UNINITIALIZED (v2 does NOT fix):

A dquot record persists on disk with all zero fields after ownership
is transferred away. xfs_qm_dqget() succeeds, but XFS_IS_DQUOT_UNINITIALIZED
returns true and the query returns -ENOENT. The v2 fallback does not
trigger because it only handles the xfs_qm_dqget() error path.

mkfs.xfs /dev/vde -f
mount -o quota /dev/vde /mnt/test
mkdir /mnt/test/testuser8
chown testuser8:testuser8 /mnt/test/testuser8
chown root:root /mnt/test/testuser8
xfs_quota -xc 'limit -u bsoft=10m bhard=20m 0' /mnt/test
su - testuser8 -c "xfs_quota -c 'quota -ub' /mnt/test/"
# empty output

I see two approaches for v3 and would appreciate guidance:

1. Fix all three in xfs_qm_scall_getquota() by merging default limits
    into the response for any zero-valued limit field, mirroring
    xfs_qm_adjust_dqlimits().
2.  Expose default limits through Q_XGETQSTATV using the available
     padding space in fs_quota_statv, as Jan suggested, and let
     userspace tools merge them.

Thoughts?

Thanks,
Ravi

