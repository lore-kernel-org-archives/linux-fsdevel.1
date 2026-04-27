Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1738386C31
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291345; cv=pass; b=JiwE7OOWYjm+LeCQv0YZoovxzUT6mAkPabn5s1xZt+/Inm8uxbz7wD0ZU67jvAnj/lh5mYg/TxOI6NN3/obBO8obGKgWz6Auk2C2dPB3kj9Ku9e3U7kbI5hfCCiISkqSQ2pAk7bwHpwnkzCuZRq/kZcDsPe6qy27Hv1RAvQr1co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291345; c=relaxed/simple;
	bh=f7oNU5FaDQl+Nkbi/6/Ivnlhsv7ogl5Ysmt1I3aNaRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNN+pJeyI73toFsJLQa1xM31FLxP/Aya209oLixdUWb0sSH6DLCfPJGR/8DB9Gkep1W6+ZKi7mrGmokCLFFFoB+joNifOgeo1N7aPUa3ZGPFDMY7C0bs62JFVv7r1f16vjJVCmwi78y6HHlxYej9iZSmLI57ueMVQGLDWHZjOzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1+/t/5t; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1+/t/5t"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67785ef88feso7274230a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 05:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777291342; cv=none;
        d=google.com; s=arc-20240605;
        b=kzbstOWjGSGRwknrcDenL+GjHhh9Ev2KxBpV3nvXe7r9ZTo+7UliY0/tlVAwGztSPU
         4g2YAbsQVqaCadSGL35MMUWyzEjuYS6/fg2VMIrO5gFpz0+KI2L80/lwagUJaq9uyjYc
         5N7F3nyu554YDuEq9tGZ+/H0XtPYi2C7ULn9kRe0qOetUgeQHt2wCUQ8SfK/Mn6ehukX
         wvD4CUNyht0rhWVmnAiY9o8x1dIMoyZPfK2oX/w54H8veviBtZXTPh4xDMcMvQhdUqBC
         KdeXULBdUhr7KzheA9p/vX7PHNkzg92hSxSRjt8UYFE0D44eFl/xWJToHztEXBiEoTOa
         1+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
        fh=np8OntkyIMXPg8QvuDztxwYUbHxOMeKVUswWPEQsyTU=;
        b=LDsxE452R7IdEYP88m05bWg19WZq1YVUOVy00Lz2T9OxYUU6ho9d8OPXGfa63ayhDd
         4+KJ89gJwopvbEPL8Rndzl/QY8KatARpXI5/UcGs75C02BF6SswksfydzPT+JonkxeuD
         P9UewGOOdtsMDr6qe3RIbWAuepqrYd3tUgN5uZuZOggIL4v7DoEGXpzE9be+znd6QvWU
         8vUpXzIr4hHdL7sNEzDH/aMgZPOxMpI8152jx0vSqJI7UwKpP0fptzfDHeGlR0MebKG/
         kf3XJphwxY8aUEzizYZpAp9oyj+SOw7zMTg1ERXFNyQjHnd+iDApik9bXOuQ8unkIxer
         vfig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777291342; x=1777896142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
        b=K1+/t/5tDElkzwFeCC6ZxiyRACFzHn02Vw/LBYrlH7xKmHiDXLt4wYemtW2FTZqlXq
         XwESTdTIuaSKGKmlxFdZV7VH70/8XG1M9UDLabWZRlhWkj1B384vUCdscpNzDAG7w6hx
         v75xrTN9J9nbtLvZfoQYyLDeDVwJW7hqQdqKPJbNHgK7isuN5aOkMvZaLm8xPMZI4O1t
         +m/iq+IwmBe16TFr7JCVoduyHfyoIRCck8+DUjQjOOt6b5Rmly0vhXgYuC8YSxj6gyU0
         BpSbIs8y6GOuSnWxWitoYOLqalvjhTLMwOlMiTBoDOuM/AQMbbPqtyJu11CUsALaRzTK
         lJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777291342; x=1777896142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
        b=a3pzzze5oXmlN8fCoaQxpfJSJ78kZhB4dDd7PFX8z4PYO2Q1qfbJ8K5eg8WTqfoqAT
         YubbpIh7mDvbNprU4VyVYea8+fBlVdHLrTx5bzSEpFE9L0gY7OJnolth5V6vjX9CT7QR
         tzKblSNABvQ5YuyvxPvX+XZ6B1V0uid3VE0O0z7W0148S7RrJPV21hXQhfrU+BQLyQJa
         nyVjX2OLV71vbUWmy2YsyBmYEcGdNXoXiY5/J5zLdG5G59DzFDaeWRYk/RdzTWkxiqBS
         oO/M/XKb5vZisljpLWD7FXBg5WIvnUv6qbpuyeChSfD5/VLto5rjwQ75VdW92Sl86HiB
         illA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZSMNO/Eavc+6PGtUsA2x+0rPiNvV3TQGMomkdRtlDZzqqhGoYDMhy5d+U66aIWkAzAMWLfnl+FadYZXQi@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbDRo8TY+2Kdg5mTI9/DL9VPqtz40zWUGC4EHJDjKnwPyzfd2
	+AedNYytpGLlREUzXJzqQBtYEX6q1DfLnN+4EHE6oFTBNMbZwKJevr1W7k1NdfO6GZ40dB9VIwN
	0/PGrXEaCVcrkNWvq/Q8nZUY/07s9iMk=
X-Gm-Gg: AeBDietbSsN+FAC6FOJosMG9pJgOgaMPsQ1F4HgE1HikTkyDLZGvDL2XpaxJx8tkzTA
	Tyc7neB5TJO6Z1CIhG6pwpWsmA39ZsWM0Jdw5o4iLJ7fHd5VM25gN3tGPQ/avcRgwRvUDuwoijq
	JyM28SdMkRziBZorPUo+FOL2uTKwv3/evzVjxrVKCT1qAsLRTJuP2Yh4NfBX5kKUMgIDcuSO7S1
	vhIzlScx1G6Z+hL8qlF8bmnWqc8XrsG7uOMypCcoxvYzm07AKn+hZpGCrKk4dTYjDmaV/zIemAk
	IvA1h3Nb6Zk9lkDX2F0pbjRXSY33
X-Received: by 2002:a05:6402:c46:b0:670:d548:da79 with SMTP id
 4fb4d7f45d1cf-672bfd87175mr18491070a12.3.1777291337998; Mon, 27 Apr 2026
 05:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <20260424-case-sensitivity-v11-12-de5619beddaf@oracle.com> <isfgwmd5hxjfn7dj7p54yzlhumx2hrkt3zw7fscs2ywm57g3hu@co27drpx24lq>
In-Reply-To: <isfgwmd5hxjfn7dj7p54yzlhumx2hrkt3zw7fscs2ywm57g3hu@co27drpx24lq>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 27 Apr 2026 14:02:00 +0200
X-Gm-Features: AVHnY4JzeOH_kK3jDOjK2FxeQTqZ9zkWJjZAaa-9jIyvUG0bleb4vaJ230stvGc
Message-ID: <CAPJSo4WmRu_64TxBsaimWOqz3VAU0TZ1H-_hw36HSqzQULm39w@mail.gmail.com>
Subject: Re: [PATCH v11 12/15] isofs: Implement fileattr_get for case sensitivity
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
	hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>, Roland Mainz <roland.mainz@nrubsig.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:47, Jan Kara <jack@suse.cz> wrote:
>
> On Fri 24-04-26 21:53:14, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Upper layers such as NFSD need a way to query whether a
> > filesystem handles filenames in a case-sensitive manner so
> > they can provide correct semantics to remote clients. Without
> > this information, NFS exports of ISO 9660 filesystems cannot
> > advertise their filename case behavior.
> >
> > Implement isofs_fileattr_get() to report ISO 9660 case handling
> > behavior via the FS_XFLAG_CASEFOLD flag. The 'check=r' (relaxed)
> > mount option enables case-insensitive lookups, and this setting
> > determines the value reported. By default, Joliet extensions
> > operate in relaxed mode while plain ISO 9660 uses strict
> > (case-sensitive) mode. All ISO 9660 variants are case-preserving,
> > meaning filenames are stored exactly as they appear on the disc.
> >
> > Case handling is a superblock-wide property, so the callback
> > must report the same value for every inode type. Regular files
> > previously had no inode_operations; introduce
> > isofs_file_inode_operations to carry the callback. Symlinks
> > previously shared page_symlink_inode_operations; introduce
> > isofs_symlink_inode_operations, which wires page_get_link
> > alongside the callback, so that fileattr queries on a symlink
> > reach the isofs implementation instead of returning
> > -ENOIOCTLCMD. The flag is set in both fa->fsx_xflags and
> > fa->flags so FS_IOC_FSGETXATTR and FS_IOC_GETFLAGS agree.
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> ...
>
> > @@ -281,6 +293,18 @@ const struct file_operations isofs_dir_operations =
> >  const struct inode_operations isofs_dir_inode_operations =
> >  {
> >       .lookup = isofs_lookup,
> > +     .fileattr_get = isofs_fileattr_get,
> > +};
> > +
> > +const struct inode_operations isofs_file_inode_operations =
> > +{
> > +     .fileattr_get = isofs_fileattr_get,
> > +};
> > +
> > +const struct inode_operations isofs_symlink_inode_operations =
> > +{
> > +     .get_link = page_get_link,
> > +     .fileattr_get = isofs_fileattr_get,
> >  };
>
> Hum, I thought casefolding is a directory attribute. At least I don't see
> a big point in reporting it for regular files or symlinks (and then why not
> report it for device nodes or named pipes?). So why did you decide for this
> change?

Where do you see this being a per-directory attribute in
https://web.archive.org/web/20170404043745/http://www.ymi.com/ymi/sites/default/files/pdf/Rockridge.pdf

Lionel
