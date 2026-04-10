Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DE38F938
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855660; cv=none; b=baS56GWUudK8cKHWtnxlBfAJoGLoiXMr+tz8QiVOSjneAA0R7LplXR+aj0nRTPYED4Tn+tWY4CTTN8FBNScQfvnWFuT5M+kfblpeCL0YjXBNSZEFwHkAoKqSCkM5zjRel6tX27ItSUbImJbw3bRTcDDTsh8PwdK17Smteqry3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855660; c=relaxed/simple;
	bh=RiYqrzidgMbgCsScOzXwsJ3z1xN8OCuMgWeQUKsiKHI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VHhjgc+5/Mk0rlYKa/+ZET0Zqo8IRNShKFUQ5KwjculjmA9YJmcW8gMq65a5caj2bJycqxjQzcPcsm89ZwSCZDluCvQiaa1SA4wfUAwVgxU2p+1JknexG96T+n71BhsyXWdahkuaNLlZC/H4s20h3g/CwJnGWXCxYpX0PcpvFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=M5PmtLAs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="M5PmtLAs"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82cf636dac8so1290658b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1775855658; x=1776460458; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzTjTx58iGVK0DXEntdhFE/+F6BbmjtWN9sC9+eRXzo=;
        b=M5PmtLAs9Cqp15P3dTpyRFu6XAaqEpPhrvg6E1nIBJgnZvz1aJeYOKuh4kOCCZJ98e
         6jwWxpHxOMf2Uplld08yKzoflSp7Ao9gsG/Y6YlgAqvmCEo/5A6DzOYVdTu9BXIsWrU8
         mXstguJclE9veqwEJnqKg1okrh0C2cAsJTn+FBzWj+jamCAx6/brNRnx6cmXwcBIWMHr
         dvtXZETnOJEKx0SMn6GJrjZNCWmAQCtjndt6lZqwkE4fSHV1gA8pAs3g3rANIO4NR4uf
         jZRyZQVoeoBsYqGdKKDXpIoZmgX0tCxsFXLSbi5OK6KJirtbtbEbTkC4V8r6fDROO1nk
         YEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855658; x=1776460458;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzTjTx58iGVK0DXEntdhFE/+F6BbmjtWN9sC9+eRXzo=;
        b=clrqBOiZWopwO+iJ7n4dOAd2usV55bOt1q6l/YjoYA9omJXXIYBOPHOnTHD0lNURuw
         zHzl3v0XPriVlpf8Fxeqo3wAGewkTrQyNOcH3VuoHFotBukZAXMAnOw3r2npoGKa0OSx
         c7Za+Kwjj5GRTDDQZTd1/7ybOysVNtys4XqfflybA8ofVg8O9MatS245cwKNruhz6V/x
         3IlI23jJTq1zYoLK2zntRtK5hK8K0PFK8ZUo2XcgFVLF7Gh23Oez/BjRXhVAeKrJekP8
         vXcbXsaL3ZEHcOLz4BPREhrxrxXTKw2JMuvizt4XwL3K3ncduG4+4PmE10RSiX9zCmP7
         KyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+SzAh1f27Va0DmwYIikxznfq546TfmkOB4ZRT6hS23gAYfM8vluGNLDjaKzYs6Xv0fpOozUZE+9FUcx1J@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTJ3MXtaOoO2uGSzJW2Y89eOCQ/kDapT0f1xh77TFVatcLR+d
	Ji6yfXJozkdall8HfBsQjGz9/d7g760o1p3ULK/Ulbl7mcUvH3+HakJgxm+H/TjbvDo=
X-Gm-Gg: AeBDiet0Kj/EUgcUc8j8B8N7jYJRn3huMIAR6t8HsgaC4Gs+lrFgveficUYl4YCC2sh
	GbinaX3ABccOHx9/cqTPvon6FbSN42aq9NS+XRhEbUVj+6Hvhnu2sugMLcGPqsnPaaZ9FYhqptA
	RkZNP3icmvWjeUIWVbeHKZgE5Khidyxc6DVd0iHvBE0K6vloQfwYY9qG8vhjIxFJLR/mI11k1qd
	V8wnUVrQufnGVq8N6Z0CxFaN7Q3mnTJ97QaDsyrhmweNkHYqScSaZmGhtgVtkzL3mrXIbEaSKPr
	JEYB1aE+FsAvPN0KW1bCYpcmzqpNPlBPoX9a8lsOKVs1zEUgyMsOBv3plbERTsKL1APoGk52qbY
	JG3l1yXw/JuDRm6XXOvHyHlf/IVEMaf8zOyI5s7CpW6TQ5/B9KRZmVtNKYPxy9IV0OrRMrFxjJu
	LZTCYu/Boc5/7OnX+wvUZr7CpVfJMVn1I/W7DLd7UkBaC5dJdk+U0pJSGju2IH7r60ncDco5nYa
	xm+
X-Received: by 2002:a05:6a00:140e:b0:82c:6f07:2d8e with SMTP id d2e1a72fcca58-82f0c411dfdmr5336601b3a.54.1775855657677;
        Fri, 10 Apr 2026 14:14:17 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0df08c09sm3573765b3a.9.2026.04.10.14.14.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 14:14:16 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <4q7d2bi2qjg6crznvr55yfnv2gcomfqdt5j2dgkrwp5hh3ynqo@cfgy5o53zjwr>
Date: Fri, 10 Apr 2026 15:14:04 -0600
Cc: Christoph Hellwig <hch@infradead.org>,
 linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>,
 lsf-pc@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BDB4B6F-D8B8-4FCA-8B3C-FA0672108C75@dilger.ca>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <adikj3y6OXgSyObW@infradead.org>
 <4q7d2bi2qjg6crznvr55yfnv2gcomfqdt5j2dgkrwp5hh3ynqo@cfgy5o53zjwr>
To: Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3864.100.1.1.5)



> On Apr 10, 2026, at 14:56, Jan Kara <jack@suse.cz> wrote:
>=20
> On Fri 10-04-26 00:19:43, Christoph Hellwig wrote:
>> I think a patch is more useful than a discussion here, that idea has =
been
>> voiced multiple times, and effecticely implemented in XFS.
>=20
> I know but after thinking for some time I wanted to get some feedback
> before I start coding.
>=20
>> Trying to lift the XFS logic into the VFS and finding other consumers
>> for it would be very helpful.
>=20
> I hope not to get all the complexity of XFS but we'll see :)
>=20
>>> 1) Filesystems will be required to mark inodes that have non-trivial
>>> cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
>>> whatever :)). Usually I expect this to happen on first inode =
modification
>>> or so. This will require some per-fs work but it shouldn't be that
>>> difficult and filesystems can be adapted one-by-one as they decide =
to
>>> address these warnings from reclaim.
>>=20
>> I think otherwise we call this dirty :)
>=20
> Yup :) I was considering for a while to use another kind of dirty flag =
for
> this and then clean it from flush worker but in the end I decided =
against
> it as it would be IMHO confusing.
>=20
>>> There's also a simpler approach to this problem but with more =
radical
>>> changes to behavior. For example getting rid of inode LRU completely =
-
>>> inodes without dentries referencing them anymore should be rare and =
it
>>> isn't very useful to cache them. So we can always drop inodes on =
last
>>> iput() (as we currently do for example for unlinked inodes). But I =
have a
>>> nagging feeling that somebody is depending on inode LRU somewhere - =
I'd
>>> like poll the collective knowledge of what could possibly go wrong =
here :)
>>=20
>> I've heard this theory multiple times, but we really need to valide =
that
>> we don't need the LRU.  It also doesn't really solve the above =
problem,
>> as we still would not want to perform the expensive inode =
inactivation
>> work inline with the last dput.
>>=20
>> So while this might be worth investigating, please keept it separate.
>=20
> Ack. With the point Jeff made about NFS revalidations I agree it won't =
be
> straightforward.

Can this be opt-in to flag an inode with `I_KEEP_UNREFERENCED` so that =
it
is not reaped immediately when NFS does iput() on an inode (or even set
it on iget() by NFS for that matter, in case there are multiple users?
And a sysfs parameter that makes this optional for other filesystems
(defaults to off)?

That way you could float a trial balloon of an LRU-less kernel, but =
leave
an escape hatch/debug mechanism if this turns out to kill some =
workloads.
It would take some time (a few years) to get feedback, but this and the
negative dcache growth have also been discussed for that long without
forward progress.  Having a runtime parameter with the intent to make it
permanent in the future at least moves the needle.

Cheers, Andreas





