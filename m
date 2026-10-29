Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274792;
	b=LbtNXdl9GwmxbnkbwQfm8TWPSykzrdjzN+ki6V7WKtdXnk92Pqm6QOqI5dvPaQ1qlafV
	 T5++T0chaQQLO+GezWYLRPc5V208tRIIKBtsPYr3c7DqXVQmp8zDzI+4pLkOHGTWmnjWy
	 nJsFdBtDmDHaMSMtQihDaqJqtM09kuiU+B0w2ULbYTS5HDn2a4ZP2e0jKLhaksPmCkQqO
	 DgxpI+RBW4Bq3ETGCkVwK/ZC3ueWezwfTMkHqpIZdSkyzFKZVw5X5FbAF/yp6NuPbFyFh
	 DGcjC+Radss3JpyNGbAifE/ktYDrMioS+uXUhtyv+oZ7sgXxD326c4jhkjb59ceJRYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jUwPwLLs3ItuEGtYWzom9wMw0uBhDScICxqoGDVoPms=;
	b=ReYO5RKkl0yXhO8r4aWyKdZupv9RvoA4Lk7IK/cbsOz19bL9cX1ZXOmNUgQCveOcsVl2
	 KVcKYO776bEtnrPWnzr4S4hsW//tubHS4ZnCMZjvP3Jh2Q0m+nADlzJDuZ9xA4kN70AV+
	 OTYvJAs6/+emRjLewN5+5MB0yXqhAYiabbsygBNJ5QMNnXZDgfvaEeVsI1RhP98gZ9JFv
	 8OFx13blOtdu6sj3ACHCjHKaYqK3OMJOdA3VwJ+ZsTtkcRra+cdIM1sCv+nJZirEfRKB5
	 Xb/V25Tx/bjZS/wfbQNGf7Lg1ttwQvSTYMRAUFhXZAtgMePvZTVjNuHI+kRa0bKFwHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RYU3cpo9;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265C606A31F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9265C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RYU3cpo9
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c49c32650adso229977566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793274791; x=1793879591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUwPwLLs3ItuEGtYWzom9wMw0uBhDScICxqoGDVoPms=;
        b=RYU3cpo9DciUFn6VpBMgihzLJDxrpN41WV68WkmYn6mVv/24wdMR5DdenFLdICeb0U
         rH08VGFDuUTfC+/dga2oBEcjdnuOSLsAWhQ5T2aA7EuIT48ChDX1jsQudCRi1B8quKgW
         2X8xd6Ugr+sVQ8EKQ6dBGexbbkxWKVXqeHnAWSFg9xCf1JE28o/EZVSyvZ3icSYESfhK
         YUk0WhiK3akB7KYllTWmbWLmG2RwoU7vmVLUeI4aeW0eSrPGM4Cm16cn9iCAfvKAF9Ci
         8vgsAL53gRinaQkTmrAyNdPVU7LGBEnWhs/8NrRkwQJGYvs0N+FtHPKUAv8JMuWWUUsn
         2NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274791; x=1793879591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUwPwLLs3ItuEGtYWzom9wMw0uBhDScICxqoGDVoPms=;
        b=y/u5CuFasBnimCY4sw+JSKBBDL7RsTMNrF/8wt2/1Xb/qGPYJ9vWYau64p9APS4ShN
         q+JPR4OiPYFaTrkLhPe17pGt8piHrtosvRqijqHzhupb5+8jZBDCPfmoUdcpja3BWoWn
         Rp9pabvkmtVrWa3BSbJiYwe5PQiu/0cr8aZaPRfyJi8QzxKpo40/nwrRYoel5Y9HtJN4
         6wn1P+b8O28cBMDAFUczEgyrPlsFE9SfGFOeFB/kvyXyoO0d3gWfWk1RVW1A569FoMY4
         FvPsqI9gc04t/iD6F75E1aeVhCtwYHWyDcyQcfQcMh8B6fVE/ywyPCYlXHQ3uLdDhUE9
         hbAA==
X-Forwarded-Encrypted: i=1; AKwUvBw1h+B6LIP6WomySAWjw/0CzIft2CxzjAgKVJx6yI9P8f9GScRFjE6z4uWNkvR36QYNxpJoQKPmfSC4bEHB@vger.kernel.org
X-Gm-Message-State: AFq9FYK3jDlDKoYWbuvA+XjLtfGpZWVjHHLCR8EMxb2BZeKMre7dOGgU
	ZVrNrRVP/IRDstuzGQWDJHrVmQd3bcQV07LOhWh0n/xVW2S36AikaPWskYzZt8BW
X-Gm-Gg: AYBFou06KUU+TXwmcKyGH4PdqS1tVuyoGCLoLevYLvl4JYSQx1KUgRWstkjDNKxpBKd
	h6j05Q/KwJWGuf8xFpL7sCkvT15CNv7Riywmv06EYpHcyvdwb2LdrGh70xRd35VT8f5CAcULmHJ
	TTBa+OfcdQYpkFbnwbqSI3cc4rUqgNpnZqKtjhM8phT152DTRZakHWXGRZRxAcRU34Pq/XfyCHB
	bunApxyAEBCILAXntRZ48l2QPVM6QgPVs/IpAsb6e/Ljg+gBmmlKnE4b3K7zuEJAptOzHCDskxm
	Nv/Y1gpxN1Z3o7GTyzxvZIXhKNcwClnVcttSAbWbrzs05zZceWZPlcV2KpDXozn9SPoU/38xg7V
	E5Z+NvKa/X/f1SnZDkKpirTQnOt7MFtgMZPRB/wLA2XjXL8gRs32Gjw+OGPop0rY892lNN5Aijl
	H8qbFf1ORsRm/BgWtckWntHJrGCBR/njMv2r2oxIPzU4g8f4xshhQPqcdnvo97cuOyY/jC+ddO3
	GtBRYoqv20khidhlj2OD/DYESYR3IEK+tC+ZF0uOAKpzBAYcsqrI4DVU1yNDG5LaHHpo5Mp9Auf
	JUz+ozjmCrJwmqIZrTZ7E7iXRDn50OsCvFN70K/OyV+iystwgzFfdf6D2KGAr+vJ42ixJw3T2Ue
	si1TA64swOvI=
X-Received: by 2002:a17:906:9f86:b0:c40:80eb:c541 with SMTP id a640c23a62f3a-c49bdd7e2admr460193066b.2.1793274790899;
        Thu, 29 Oct 2026 04:53:10 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd34f465sm721068766b.8.2026.10.29.04.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:53:10 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:53:09 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: koraynilay <koray.fra@gmail.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>, Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sean Smith <defendthedisabled@gmail.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: add provenance time (ptime)
Message-ID: <auMzpUIEmGCE_x_N@amir-ThinkPad-T480>
References: <20261028134728.294127-1-koray.fra@gmail.com>
 <20261028134728.294127-2-koray.fra@gmail.com>
 <auILs54TUcWXf3us@pedro-suse.tail5790ac.ts.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auILs54TUcWXf3us@pedro-suse.tail5790ac.ts.net>

On Wed, Oct 28, 2026 at 02:56:39PM +0000, Pedro Falcato wrote:
> On Wed, Oct 28, 2026 at 02:47:27PM +0100, koraynilay wrote:
> > Add provenance time (ptime), indicating the time when a file or
> > directory was created. This is user-settable via file_setattr() and
> > retrievable via statx(2) (using STATX_PTIME) or file_getattr().
> > 
> > The semantics of when to preserve this new timestamp are the same as
> > mtime, the idea being that there is a correspondence like this:
> > 
> > ctime <-> btime
> > mtime <-> ptime
> > 
> > so every operation (copying, moving, ...) that currently preserves mtime
> > should also preserve ptime.
> > 
> > Furthermore, in order to avoid the legacy FS_IOC_FSSETXATTR accepting
> > FS_XFLAG_PTIME, add an FS_FILE_ATTR_XFLAGS_MASK mask to support new
> > xflags, and use it in fileattr_to_file_attr()/file_attr_to_fileattr() to
> > allow ptime to be used with the file_setattr()/file_getattr() syscalls.
> 
> Random comment, but: could this be doable with xattrs instead? I'm not sure
> where I would put the xattrs code (if in userspace exclusively, or if hooking
> the VFS up with this, or if doing it on the filesystem side), but it would
> surely be less disruptive than modifying a bunch of filesystems one-by-one.
> 
> This patch is quite simple, but changing btrfs, then ext4, xfs, etc is a
> mess, and inevitably you can't get these timestamps until you upgrade your
> filesystems.
> 

I disagree.

I think that creation time should be a first class property in
filesystems that support it.

Thanks,
Amir.
