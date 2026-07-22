Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C363932E4
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692742; cv=none; b=LEsGQSUAXBu+q6hreMCRQv7Ef9pWun8lfoSIeQTnCzk7/GqMhBNJ7MTGpQF3zTDl41+Qo0LbND0hZwcZp0CFV0IzwCQgionSGWaw7FCQipeLBO9QjASSIbq0gySunUlIVspQUhUl2muxTU9Pl5Ej8+nz4hSBdEQyvP36vfueYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692742; c=relaxed/simple;
	bh=BNK1Abq1MfA6ryPKoGxTEIRZlnBOGxhtAMdHurrbuL8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dLKS564I/13bS18kv1OLEcwZYSiUk6zPjIDSuVUugPjK73Xbp1PFSNckJQEivdKPMvCBEXa2aoWXMjMLLa7tvL2d/Hve8KCqZYbOHvvtI8L9hyX+vFzBT0yTZVu+JjU/gQHnJ6Y8umPyT91KzcybytYVeiooqeqTi8aJbVh7HIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNSRcSZw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNSRcSZw"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so9136630a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784692741; x=1785297541; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FO0PIl4jHeZm6CVaqy5alytFRf8x9mC+vdko7KzkD5s=;
        b=KNSRcSZwItRqeumMoitTxvZmTC562yUMSwuXSCSXj23CQO+r5nFpiTTvOqUCQmjXgE
         3XVzFdbcamCrnYF1JCfJwIVCviJscXUxT6/Tfzkgca97bUoPUsYqz/hDToqCLTQb2AYB
         c6wry0GFBwxDhs2OMoFXCPJ1keSvh4TJ+R9W4uiWAU901fH70ZrhJdv6dVCakW2FBf6x
         PbgVu8m0ipdsyrxghyRPgjQl/sjGqjx9p0FVIaxVA0cRwUCne92+Wx3k22Jdw08mqzeH
         T8sbL3GhN/KNdcXEbeGR1X2V48Y7BF+vL6CTIW4bRcJhV0ASpq9hm4ieHtty34xorB2Z
         sgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784692741; x=1785297541;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO0PIl4jHeZm6CVaqy5alytFRf8x9mC+vdko7KzkD5s=;
        b=iQ3XWqFQNEi0+0K/oFv+IfEKbp26bzJdqHiv0t7CnRfx5efdYGJblpc82+AW26009v
         9KvLwS0byRf8oZBsYesxONruB694WNGD8fpJ6BMikvEX+gGfurONuLzxg9asTRZWG/mG
         T769lYnWJl8abPVcoyzrqRTMoA+Rh0arq7Cbv8WYcfT/4rF+vJR4Xqwv7tt6S+9169uH
         i0DENvIYzss09hV/pju5QmhfzvkP8VJkloHwAgaw28m81lCCK6u2EVGGozVz0yLhVNK2
         DXctOYRaZtJkbkOPbLNKGWq9RdADabCbMM3Vdk85pykySsky6HKzCRbxp918T18S9kru
         rmDQ==
X-Gm-Message-State: AOJu0Yzd+VTXxUIXTT+NEF2+OhZUN+4f5xyOkI+Vupz86Whh6Ui7adLY
	cvQyCcaeRnK/luZpsc0MJD1tSg9LhZa4giwLLsjpEBls6o48OscV6uPe
X-Gm-Gg: AR+sD138X5xkCBL9DuyIkJjtJNdw2RMtS4e4AFEuG5UcK/4skixCTrHtIWLumpxKEE/
	tChj6MwF1eFZ7YjIZwm0C0HKZ/Mvr8OIXDtuH912ifwLTuEu9PtOm8rWr/Kx4AjYXJYDrFhX4ii
	95vf3tzP0mDSRPt4heMv6MTqO0vGQRmZF+fBA72OmMLMhQoONBXWzc4niek5K9exu+pnBSUWF7w
	RsqVeKr/S8AxCjJmHKiwf/WzhOL8SWeHkwDvzOU7Etr39xAcdHkVKZduBCUKZ493KV/In1/t/1L
	l4ZpsxbRRbUFX7TDudtGON/iHFFE5TPT+2CwOSxLYkIsShEzGwdUc7J0heT9gpX99Za5oW/QMjp
	FAT7/kzUPXNSxItTqhPTaIk3WwX1nOLpk2sEO/48Xzf2m4+slWFiUDlD6chUBcljqmraEmYzine
	g5qBs=
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:fb94 with SMTP id adf61e73a8af0-3c3ada37416mr22623030637.54.1784692740769;
        Tue, 21 Jul 2026 20:59:00 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e0818e4sm4154541eec.22.2026.07.21.20.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 20:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 20:58:59 -0700
Message-Id: <DK4SRXTMBB88.RHDTPAQOGD8J@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>, "Jann Horn" <jannh@google.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Cole Faust" <colefaust@google.com>, <brauner@kernel.org>, "Farid
 Zakaria" <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com> <CA+9F0A3uywPD8vk=O3Fg7LUgY9kYLtrNNLCcf-62k4RGrgQ5iw@mail.gmail.com>
In-Reply-To: <CA+9F0A3uywPD8vk=O3Fg7LUgY9kYLtrNNLCcf-62k4RGrgQ5iw@mail.gmail.com>

On Tue Jul 21, 2026 at 5:26 PM PDT, Cole Faust wrote:
> Correcting Farid's email.
>
> On Tue, Jul 21, 2026 at 5:24=E2=80=AFPM Cole Faust <colefaust@google.com>=
 wrote:
>>
>> Hi Christian, Farid,
>>
>> My name is Cole, I work on the android build system. We have similar
>> goals for creating hermetic and relocatable builds in our build system
>> (a custom, android-specific one). I was very excited when I saw Farid
>> working on $ORIGIN support, but then somewhat disappointed when I saw
>> the new BPF-based solution.
>>
>> Our usecase is mostly to decouple the glibc version used in the
>> android build from the host machine. We've had several instances where
>> our CI machines are running old glibc versions that cause problems,
>> and they're not trivial to update. Ideally you should be able to
>> download the android source and build it on a modern linux kernel,
>> regardless of the userspace.
>>
>> To register a binfmt_misc handler, you need either root + modifying
>> global state on the host, or to make a user+mount namespace. But if we
>> use a mount namespace, couldn't we just mount the interpreter we want
>> to use at a fixed path? I thought one of the main goals of this
>> features was to avoid the use of namespaces because they don't always
>> nest well; Farid called this out as a problem with buck2's sandboxing.
>> In android, we don't yet have any nested sandboxing but there have
>> been conversations about increasing security of the build using
>> something like gvisor to isolate the build from the kernel, in wake of
>> the recent AI-discovered local privilege escalations, after which
>> these complicated kernel features are likely to stop working. And
>> requiring root is definitely out of the question.
>>
>> I also wanted to ask about the security of this bpf solution. I
>> understand there are some security concerns about $ORIGIN. Why is this
>> new binfmt_misc + bpf solution better? An attacker will still have
>> more opportunity to place a malicious loader relative to the
>> executable. With the binfmt_misc solution, you will be able to only
>> have it active for certain things, like a build, but that's only if
>> you use the user+mount namespace to scope it. From what I understand,
>> Farid plans on registering the handler globally and persistently on
>> NixOS systems that want relocatable builds, does that not make those
>> systems susceptible to these concerns? (correct me if that's not your
>> plan, Farid)
>>
>> I can't really think of a better solution than the originally-proposed
>> $ORIGIN support for build systems to use. I don't care about setuid or
>> complicated filesystems like memfd, so I would hope it would be
>> straightforward to just error out if AT_SECURE is set or if any issue
>> arises like not being able to determine the directory of the
>> executable. IMO it's fine if it only works in simple, known-safe
>> cases.
>>
>> Thanks to both of you for working on this, please let me know what you t=
hink.
>>  - Cole

