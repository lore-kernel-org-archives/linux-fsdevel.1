Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683295;
	b=4brcIAupvN2mpQzxgGQiVFK4oHIf5Vyue07s+fWOIzi67V7OoE7ZDgU5NBzXTfUKrZoa
	 tIBsXO7JjDNbch8hrXsaXaEdYlkYg1USYbwxW8gdM6zEgtF3/jTQA7sarW3NmwDCNBAZ0
	 sTMQWa3WfZqTT112V5p9Spo83XZHcTNRZCiXkfc2+Rax4yyhewe4gdYbJjYabPLivQ6S3
	 3xcG+5VG3GiutHQxamgpG4uO0DULqD5CysLn8RT2jIv8VkhlTCSzI7/4U7VqSQruA+yhS
	 JTkCiXDraUAbNbsnpfAcenUtBdKarAATCKbzORJmiaDkigQ8Hml0EOZzOBGBMxEgvxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683295;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XD2aXTSUuiCiLHpGAugxfZVXZCiLEmjgR9QKZY9m6mI=;
	b=ubAwFdVpaxHbzt2Di2utf+ioqlRyij7sFb2h74vwoE//PWlYsP21UIh0PM0yI/NqSEKX
	 Ag0rQfu5zfNIQ1V5U3Hl92ysyGMvZ0fQfQpnrD7aht/XvprpZzv3xJfL4EV4qP13BmJ2O
	 xaee9E3fktCYjLtW5AMOZOiHpC8RcC1P3obn57kZU3Am2SFxtjwriSBF7fCfM8u74vqpq
	 j9rB9YYl0KXpu63Xx2V15gEzrSnHGpxK3lNS67GJUfYjaJuV5LvEPhrlDsY3AxKOZ6Wfn
	 eNskMgA2vHvwlCWGGLVYwtYorYxEZ+unmSogvWf05lrsfDjvUOC/mGETHJc0EOgd2IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKZKjXt6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE337606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKZKjXt6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A61F000C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 08:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683295;
	bh=XD2aXTSUuiCiLHpGAugxfZVXZCiLEmjgR9QKZY9m6mI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NKZKjXt60ggmjgkQWJs7L/z9sR6LDbN6c5x8VpKkLZDQE53ha1ofDe/J6yl0UZS32
	 qzJaM4+wzGcmjm4PZRwDqFWYQD3EKl45jX2orGnelqnE8eYqfoHH7dytYIpYBkndMJ
	 12B/SyZJnYFxj5CVxNehviesZLrza16sIOOMpM7lxscw0ntUIVaH/GFRgpnbQ9JlNQ
	 V3VoRoKZ03LBCJjWduez4ImuY8wxZu/j/RF8Ot8LbprOmcOgzcnyItyBoN6DfJ5jpw
	 7Ufd0tfHZr7iRU1FmGH6YOTfnUaeGK4YCMlOQVoRoYobzTHkSGmeu7IAfFqi8J/fhR
	 ZIochXIzrnusQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c515369b627so708503366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 00:54:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGcma1gXIBGVXHiZgiiqlYZtsVBH+qa3N/mS/d0vAv1GpCVd1ajRf17KxlOPTxG6o0ClfmWzcQQCJKJGxUq@vger.kernel.org
X-Gm-Message-State: APuU4Z/YYpRqSYSjykI+R2TYLiD4p1coBRo+z6gMIOWxP5KahSFXSY+9
	RNT+IcZql1whtN4+2d4f1Vag1hQ/9VwaoAGVwy8fksC6NOyKdaUaWOz000nM9r6pGKjGLhzb0V/
	K6mS6TkIIOR/qzoA93crraS5ElB2CSYM=
X-Received: by 2002:a17:906:c102:b0:c51:373e:d6a9 with SMTP id
 a640c23a62f3a-c513aace989mr1575933166b.15.1795683293890; Thu, 26 Nov 2026
 00:54:53 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124230746.850528-1-shaopei_1012@163.com> <CAKYAXd_ap120uprmarov-GuO0fb1eXEgw-U8G08L1xRJ9bv18A@mail.gmail.com>
 <20261126075247.850895-1-shaopei_1012@163.com>
In-Reply-To: <20261126075247.850895-1-shaopei_1012@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 26 Nov 2026 17:54:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Xc0XbehABVUOncbcDYxvfFg037+FxDivkM0NZMg29qQ@mail.gmail.com>
X-Gm-Features: Aa3M54rKxK2yysLAQ3KYIgf-px-qmHSK27mnhAx20UoLmih8jMhUz2_ENxHtKqY
Message-ID: <CAKYAXd_Xc0XbehABVUOncbcDYxvfFg037+FxDivkM0NZMg29qQ@mail.gmail.com>
Subject: Re: [PATCH v7] exfat: add EXFAT_IOC_COMBINE to append a file's
 clusters to another
To: Shaopei Zhu <shaopei_1012@163.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 4:53=E2=80=AFPM Shaopei Zhu <shaopei_1012@163.com> =
wrote:
>
> On Wed, Nov 25, 2026 at 11:18 AM Namjae Jeon <linkinjeon@kernel.org> wrot=
e:
> > Is there a specific device or product expected to use this feature, or
> > is it being added as a potentially useful capability without a
> > concrete use case? If there is a target device or workflow, could you
> > share some details?
>
> Hi Namjae,
Hi Shaopei,

>
> Thanks for the review.  Yes, it is going to be used in camera products
> that record to exFAT SD cards.  The open source user is exfatcombine,
> posted for exfatprogs [1], and a test for fstests (exfat/002) is posted
> as well.
>
> The workflow: cameras and dashcams keep motion or position data with
> the video, e.g. gyroscope and accelerometer samples for stabilization,
> or GPS.
>
> The products on the market keep that data in one of three ways:
>
> - as a timed metadata track inside the MP4, e.g. GoPro's GPMF, muxed
>   while recording, so that the samples are interleaved with the video
>   in the mdat box and indexed in the moov box;
> - as a separate sidecar file next to the video, e.g. the GPS logs of
>   dashcams;
> - as a trailer appended after the MP4 boxes when recording stops,
>   which players ignore and stabilization tools read.
>
> A sidecar file is lost in practice: users copy, share or import only
> the video file, and matching the two by name breaks once either is
> renamed or moved.  A track needs the muxer to take the samples in real
> time along with the video.  Where the sensor data comes from another
> writer, at a few hundred samples per second, it cannot go into the file
> the muxer is writing, so it is written to a separate file in the same
> directory during recording and appended as a trailer when recording
> stops.
>
> That last step is what this ioctl is for.  Today the sensor file is
> copied into the video file, up to tens of MiB per recording, while the
> user waits for the camera to be ready again, with flash wear and free
> space needed for the copy.  With this ioctl its clusters are appended
> to the video file instead, and the sensor file is removed.
Okay.

>
> > I suggest changing EXFAT_IOC_COMBINE to transfer only the source's
> > cluster chain to the destination, leaving the source linked as an
> > empty file. Userspace can unlink it afterward if desired.
>
> The sensor file is only a temporary part of the recording.  With the
> unlink in the same call, a power loss, e.g. the battery being pulled
> right after recording stops, leaves one of the two states the
> recording application already handles: not combined yet, or combined.
> With the unlink in user space there is a third one, the combined video
> next to an empty sensor file, which looks like the first one unless
> every application also checks the size of the file.  It would be easy
> to append the sensor data a second time, or to leave an empty file on
> a card that users read directly.
>
> Doing it in the same call also refuses the whole call before anything
> is changed if the source may not be removed, instead of leaving an
> emptied file that cannot be deleted, and it removes the file that was
> passed in, not whatever its name refers to by the time user space gets
> to unlink it.  The unlink goes through start_removing_dentry(),
> security_path_unlink() and vfs_unlink(), so it gets the same checks as
> unlink(2).
>
> Does this address your concern?
Unlinking in the ioctl does not make the operation atomic against
power loss. It only avoids the interval between a successful ioctl and
a later userspace unlink. I don't think that is a reason for the
kernel to perform the unlink. exfatcombine already has the source path
and opens the file to pass its file descriptor to the ioctl. It can
unlink the source file after the ioctl succeeds and report an error if
that fails. The ioctl should only append the source file's cluster
chain to the destination file. Callers must prevent concurrent renames
or replacements if they need the pathname to continue referring to the
same file.
