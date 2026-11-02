Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793631257;
	b=YXHh4I7j6S5LNf6FfXx5867SrTN+LbNLyRXb1xL9mlzfRYjTW4SeSt8RteWmfQn/CTdD
	 C+4DuNU8FA+vRKuS1hYdWtRwNfwRyH9S60O443klEDYoQa0fY3MraKbKPzfOHxLKuq0ir
	 hpwmP4kjTFeIOkYjUHYG1fEpBUydvz7dfSx1sOyWuCwksyH4WbGQtUfKmbTyWpDyF0fCn
	 LKQhiOgmaqL0ofbejjalb8ShHPX2ztLGyxrvcGYLYy4S/89Wi8F64bnSG+nbWyXdr4wER
	 cKb3vfDlqKUoJnZCfhA28UOvJaNx8HD+yYTl9xhBM5/8Pafl5K8Emiu33h9dGICn8Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9S45ohuGWD9KQ2+FLxafTobKS8uDh2Gv9DIfHDLQSno=;
	b=u4/ZIxJn+RO2hutXrLY4hI95EO8KohrsEvsG01TILNZUyGplk4ikI/rD+GDoml39wiJ6
	 YtcWJFlcAsNzLkO3enCRMlWm/uMwnN5BCHOoLGHbR6NTH7UbVOG9V+2fNUVvzi+aULB/M
	 4k1Ygd/tp8MiVZYQU6uDmTFsi5ZBa/2USq64SOt2vFck6HwpDNJjTEguvtVvmA4+DSl1p
	 SI+sNOnL2Pnr0skNg01XwlbXz7FIWiM0p7Mhyx+6oUBRzzH1E3YjSWSrKIVR/ji9dT5E7
	 +d2Sdcxo9jRucupWGqptaaZ0gLEz3wDQEAfWFnjjjgCj7+3+fexESCOvJg5h7XknJ8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ytXtI9ur;
	arc=fail smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A744607A8A1
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 14:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A744607A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ytXtI9ur
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c418e215671so399872766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 06:54:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793631255; cv=none;
        d=google.com; s=arc-20260327;
        b=Z6BJSXTD8OTyDrqpfknrbPiSsqBJuWpLaC77QntgIW7BPgKgnEMz7T3RwdfKbp8nLS
         1mjCIcOXQPH7uQ3lxT6P3lavug0krQtogJzF4d5+qOFKS4dcx01TPeipxEcD2YxWMLR9
         DDYsa8VXhEoqJJCpGXQgQe+kkipMJz0QpKS3l2IOWbuaEnGiTNAB7Dbyk+5QWGXWlJMB
         Zm7IlUebrOiPt5tEVn/qLEIEtWvwzOtbF+edJPCw2mg5LPNbJSnQMQGMuweSceXNbJUe
         pR8GIH4pM2pL9QNqtb8FhzMTVUaDDW7HkN1e1Gn8sfGUw+lcR83m+wXUGLpFQ+iluFKg
         YoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9S45ohuGWD9KQ2+FLxafTobKS8uDh2Gv9DIfHDLQSno=;
        fh=gaotJGOXdkMWymYB0/Oij6cb/X2OXg/BpRKwTMmimJk=;
        b=hFXAdYkLf8T9Nnl1NAGIdlAylm0+Lc/HJXDpCoKexO+HfcpxogwvQy3n4/n1t9fEYM
         l1oiDhMg9acVbbBy2u96k/k1jAuiscFIqFd1F8LuVr9nmI2xHeABWfO8rbWgbqhVFOcn
         lzjSXrR8f3XsYkhXpD8gzpabdSuzpT0pYYVHlJ9twxvHz4aYWl/bn1l1+2iwLa994JQj
         oLXcGNNc7vpVDgkjmEfTC9L/SRcTiTok5IClCtuSTJrWtsjydeBL6Vq8V6JTEL623Lm2
         bws0w9gCVDXVtNoS4y5FIoMOr9hxpX33ox3ELarjwAwoOYbq1ocLUEYc7y5oudF8maUO
         4g/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793631255; x=1794236055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9S45ohuGWD9KQ2+FLxafTobKS8uDh2Gv9DIfHDLQSno=;
        b=ytXtI9urkBOvMSxNBLZNENQibMB/0gzzBc5DiEZfC6ZXmrvapm+egYYm9kWonaIvc7
         gYzuqpT4m18qhZoQbQrZpb2T+++MNHRQx0q7J3FLCRnOAViXnbf2YyRwymv8LzrKU5ji
         c3hNN+VN0CxAfA3VukdFS8J253OYA/wQYb0p1qfHH4obnQV38SG/fN9Yf7nEhJGmztoi
         1mcZoYTLpkCI+nVXEmAumOVmkqWZlicJwK24ec8XXfAhmX08g++Txd1372FncrDXskXF
         /MXJugsAdWJ1HQWyCTfxIUTUGG1CvKf+kuV8FP63sJZFLKd5uBbCsQI0I5rMlCQAlggs
         AlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631255; x=1794236055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9S45ohuGWD9KQ2+FLxafTobKS8uDh2Gv9DIfHDLQSno=;
        b=iWp1OYFjaZdBYGS1DZGDd5kn9YgejcRVDLodaJOA/piy2/6+xQn3DYv7OAnXFaCDP3
         Dbqa3t/L/XqAihRucORDOeg3YiHa3CQhcBIYb966hDrZgrZ00kiqGUiM3qSUyEK1P8FV
         kcXMdn17mQSw1qeOMWVXHzsJzuvlGce7FiDYrjLzQmn55xpUv11OkeQbwCTSmCgjGiW8
         ehCyYnrgqNUmeI6ub6Squ/hsInPKRdyW4P8KIxXfxxPDPWbXloqPdH1Y9zqNX/YsQXo0
         y3PBaHDxOEosQ6Y3hiGqBmihaTEqE7j/L+yGmRgyCYzu9WeoswXBcdxUD1fT32vU1l6I
         /9sA==
X-Forwarded-Encrypted: i=1; AKwUvBxmTpX0cibyh0t8/tRf0uDRGh5yR7YjLxbAgL6O72C0uyYfQCvjuUCJ+i4ZNb5J1Am/G9I3q3Cw6igtU53m@vger.kernel.org
X-Gm-Message-State: APuU4Z/KM/fPaYRtHhBIjUbhlARXISJSn+HrruPa7uxGUMHROnRA2wlM
	0gHJgsl8DWKfT+/jazWMlP+FGa3nTfLZ0NNMUHDs5jBVKMZK3c2wNvJ4KK7mQTwobeey+NyOTM5
	ODSCBIftBYg3zvzMJMtivoNWyhYNtgEI=
X-Gm-Gg: AYBFou0PWvcQD9rqGXDsUhyGwThsmxG76ptsx9juyK91ObwJYM0D4crjPmpHH/KmeE7
	N8cfrPA6eIvdNzcvHlQGdQs5JXjQsPp2FzGswrpJGopDdWvquG19c1WI877rZ1mnF/kiCiS2Knq
	WTue2JvZ1uryx+WsOKqwxm1x59z/xLDB89DgMcTt5q23YRbyl7neKDDLeICJCqXJGyN/6Qkabl2
	gmxnmBTXFlLH8gHpmRx0h8LkxJG9Xd7DWAcAwOKN6wEwYYjz/VIIKv/pvpWtcSGAyvQSJSQqIch
	k9Kb9sCkSnuIN3HhWzGpaFBApyK5jSZrBJs4FFPKaYElAmUZQhfN3+TLOoOATDPs/6ktYXUNBp8
	k5LHwkXevsv+y537VHCq/7cwC0jql8YTN3x3Psd5VRXbsS913VnxrFK2s2CvPwUe2HOyCw7C8fy
	MxA4l4VyAM1KcetCs=
X-Received: by 2002:a17:906:eec8:b0:c2e:317e:d711 with SMTP id
 a640c23a62f3a-c4ca7aac250mr889529566b.27.1793631254792; Mon, 02 Nov 2026
 06:54:14 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101015551.786044-1-koray.fra@gmail.com>
In-Reply-To: <20261101015551.786044-1-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 2 Nov 2026 15:54:03 +0100
X-Gm-Features: AclHuK8MPfC_dz5RbDokIFz7RFGIRe7sv4kFXfjOWYu6Sb9FQLskiRuGBNP5Y1c
Message-ID: <CAOQ4uxjkG=1j1z==Mv4wzkF042rXstodokKnBfMFBf2e-Eztmw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] add provenance time (ptime)
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Chris Mason <mason@kernel.org>, 
	Jan Kara <jack@suse.cz>, Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <cel@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Sean Smith <defendthedisabled@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com> wro=
te:
>
> This is an initial implementation of a new timestamp to indicate the
> time when a file/directory was initially created.
>
> This patch series takes inspiration from the one by Sean Smith
> <defendthedisabled@gmail.com> [1], but using
> file_setattr()/file_getattr() as suggested by Darrick J. Wong
> <djwong@kernel.org> in [2].
>
> The semantics of this new timestamp should be at least these:
> - it should be the same as btime on a newly created file
> - it's user-settable, so it can be preserved for backups, filesystem
>   conversions, archives and any similar operation
> - it should be preserved every time mtime gets preserved
>
> and the correspondence with the other timestamps is as follows:
>
> ctime <-> btime
> mtime <-> ptime
>
> Examples:
> 1) a .zsh_history file created in 2019, then after a few years the user
>    decides to switch to another filesystem, copying the .zsh_history to
>    the new home, in that case btime would have the timestamp of the copy
>    and ptime would have the 2019 timestamp (just like mtime would have
>    been preserved)
> 2) a symlink created in 2020 from the home directory to a /path going
>    through the same process as the .zsh_history, in this case it would
>    also make sense to sync the ptime to the 2020 timestamp instead of
>    keeping only the btime (so the inode creation time).
>
> The proof-of-concept code (for testing) for stat(1) and cp(1) is
> available at https://github.com/koraynilay/coreutils (master branch)
> (Note: these coreutils code changes are a prototype and won't be
> submitted upstream as-is, but they work as expected in simple stat and
> cp -a/--preserve=3Dptime tests)
>
> Lastly, the name "provenance" and "ptime" are not final, I personally
> don't have a strong opinion on any name, but while testing with stat(1)
> I noticed that "Provenance" is definitely too long for the normal
> output, so another option which would fit well is "Origin time",
> abbreviated as "ntime" (OrigiN time) and not as "otime", as that would
> conflict with btrfs' internal naming and create confusion.

FWIW, I agree that given the existing uses of btime and crtime in the
kernel and various XXXprogs, using 'ptime' for kernel code is probably
the lesser evil.

The question of how to display this in stat and tool is a different questio=
n
that can be left to the userspace developers.

The UAPI headers uses Birth time language and stat displays:

Access: 2026-11-02 15:22:27.067329367 +0100
Modify: 2026-11-02 15:22:27.067329367 +0100
Change: 2026-11-02 15:22:27.067329367 +0100
 Birth: 2026-11-02 15:22:27.067329367 +0100

If the UAPI headers will use consistent language:

+       /* provenance (settable creation) time */

+       __s64 fa_ptime_sec;     /* provenance (settable creation) time
(seconds) */

I  think that the man pages could be unambiguous:

stat(1)
       %w     time of file birth (immutable), human-readable; - if unknown
       %W    time of file birth (immutable), seconds since Epoch; 0 if unkn=
own
       %p     time of file creation (mutable), human-readable; - if unknown
       %P     time of file creation (mutable), seconds since Epoch; 0 if un=
known

statx(2)
       stx_btime
              The file's (immutable) creation timestamp.
       stx_ptime
              The file's (mutable) creation timestamp.

And userspace tools could be displaying ptime as:

Access: 2026-11-02 15:22:27.067329367 +0100
Modify: 2026-11-02 15:22:27.067329367 +0100
Change: 2026-11-02 15:22:27.067329367 +0100
Create: 2026-11-02 15:22:27.067329367 +0100
 Birth: 2026-11-02 15:22:27.067329367 +0100

If they want to, without that being more confusing than Provenance.

>
> v2 changes:
> - fix permission bypass leading to ptime update on immutable and
>   append-only files (found by sashiko[3])
> - normalize ptime timestamp as done in fs/attr.c:notify_change() (found
>   by sashiko[3])
> - fix wording in vfs patch to be like the cover-letter
>
> v3 changes:
> - vfs: reject setting ptime with -EOPNOTSUPP on filesystems that do not
>   support it instead of silently ignoring it (found by sashiko[4])

Please see my review on patch 1/5 on exporting the supported mask
to userspace.

> - vfs: fix not being able to clear immutable and append-only on files
>   with ptime, and allow updating immutable/append-only atomically along
>   with ptime (found by sashiko[4])
> - btrfs: validate on-disk ptime nanoseconds and reset to otime if
>   invalid (found by sashiko[4])
> - btrfs: avoid re-assigning ptime on unrelated chattr calls (found by
>   sashiko[4])
> - add ntfs3 and exfat support as suggested by Amir Goldstein[5], but no
>   vfat, smb, or nfs4 yet as they are a bit more complex

Please explain what makes them more complex.
My concern is that I would like to see that the proposed API fits the exist=
ing
fs and we won't need to change the API again later to support them.

Thanks,
Amir.
