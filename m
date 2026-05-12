Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1B39FCD7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578740; cv=pass; b=fMlUkW66VKr+vcSo4H1ZDyG7MSJso5SbbUITPalkew6vUw5zjGf2WRgNXcB6lPUO7rXJ9lZ8Vcf5HfgO6ztaN8cuWkiwm0uBpX0SITZnY00lpqDZw+qRqSQOkIEV0wRSGnSWdjP8bWwIoh8l6IRVSM+80zK1okaA6/EGPTYWgWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578740; c=relaxed/simple;
	bh=nBMJidNHt66HghgmXUZTCEaSRlUL9/FTHnwxbGP1apM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldQePZrHEHN+wTXq2oelo8engh9N/VSd7ctig4CJZ8ZCxTaH5sKdhFDkq9GPKeozTKu1CimNKsRFDMdenQYJgbN89WqU4ACSA9H52IXxkO+oN3rAnQLe6fkiSfFezpgG/LylnVTu32La3lZr84z6CJbEA44cY2/5hCjV1MPk9gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KFMXl50u; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KFMXl50u"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-515226c0cdbso1139671cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 02:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778578735; cv=none;
        d=google.com; s=arc-20240605;
        b=E1LdRjclNz8iBEHnaaecHWIEZidmopDpDuWNbx0pqjIRe3QH7BQUONytBU2HS0Upv9
         +cDG66dVT6NSjHrOY6b+wUDeqhn7xETveWxZvvLsjb96tv1vhsnpeNcQ7tv/rqoiQ8RT
         KhBBVARlKFloItGDYorF1G92JnMqYvSAUYkgMPrYdFQgGQ1oaglq88ZpdeBnsSA83S/B
         BrBXO4bwpX7OEMyO0LYDmWF0uRE9U6Ws29iy4zS4K6XpT7CBUSzq2tOUyHQF/Sh1CV95
         tsQOEvCk3tVcmSu+Li0eX7CbKJr+rVZ2pyZxW6+LZkwxxEhwnBVryZODCAUIAs9oMgJ6
         VNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tudgoBstBgoWV3PkywqJXS+rkKtuXHKcvUGzzQXZQEY=;
        fh=G61z/honO+pT9+bKOFcRxSkjmFlT5mxJknsBR/QJRGA=;
        b=YwD2QYJiMvM1J3/YM8HgxkxvrkwitWCFdnWK9tJO5X89zKSg2qhrmQ4X8XnYyMxghA
         pfsOx/0trV5zy1ke0mjfYkkBiQuxg+Yl5XYgDFFZK0FlPWCP6me5Wg2v6U0UOv8Qlso4
         xzRZTB1o5G8GB89ytkw2wIkbMStQDruJbhb/K+20sdbMGNeX7kv/EfN7ewkNL8lTSclR
         I08pZTcy4NLAbAa6yoWQ47sLMg2xylj4gMOXKVEtSHTA2Ju2V3iAwXjwj2nkGTXAWyBl
         S7kqF798kRU6eMxT/oNxkz2+FD2kacEXvht6WAIVIY59D0RFCASLJLi+KgGx87kScwSa
         QePw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778578735; x=1779183535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tudgoBstBgoWV3PkywqJXS+rkKtuXHKcvUGzzQXZQEY=;
        b=KFMXl50ufb/876kEL1TQzl2OIEXRqJL1BdD1PSlgvUxDFxN3daUMPhedkLnxQNN6fR
         p7QNay9/xbYguCqs50ofMujATCOWVc0M7NRW9yXayPfPC0jnJD/Md5byS6t6KqSc7Vd9
         zrTSHC/7ch7uy6jsTTpQ6+XVuBQkvODc5p1pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578735; x=1779183535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tudgoBstBgoWV3PkywqJXS+rkKtuXHKcvUGzzQXZQEY=;
        b=fb2sCnIWP0pAcX4INhQ+mfsjTjWVhE56hfv21eta54Gbx0ejMAZMfHqgvwSnO8tb80
         vjTehV75uJEG0ok6kvUOYtjNh0KW3tR36C+Tkijt90AE/IIMcPVbk60S3q7SIdChCsU5
         WVdKuqzGFYIbxD9QAXeapUtoGasiLcCzXYPaE8wYtHd69nUed/CXqzTyMHC8SHgF2Da6
         +ISJYWEfMpoaCyOU9uAzTr5xHJKzly+zHSpbWgaYtoA3psBJDOsRm0hxlG5C7vyOwV/S
         ddAC/P4sshQDlNoAODWGRKcZCFfqIpGeV0D0auLmM8f3ZUkE+oEUOV6X3mXyHptSZfSm
         JhYA==
X-Forwarded-Encrypted: i=1; AFNElJ8KVbEKlaQQNHa2xMq6HJB5Vv0lBQCe38VMzenJTJ7WM2vke3xXTvjsMrWEt4McYU0Iv3NdI4hPdubpBOp2@vger.kernel.org
X-Gm-Message-State: AOJu0YxyT0pMKXjWkI/Fsrc4kZDRWAs68FvoYaNQ9K8PeIQaRdclP2hx
	MswXpJbWnxjvW2rNAplTfMzdadSBm3djLxgcoaalgWSyAIn5uypx6q6iYGGad+LYpgj34tiCbA1
	aY94xf9xS+yS9P0ryxVdQNh7aA5Hoh0B7xRZ3rqfJJg==
X-Gm-Gg: Acq92OGPs8pCWeE0LEDA04tjR9tXwB53I/C0j0nSAcZiDmiIEvuY6YPbRNiLOhP06Wu
	+9jdDryuJYAwPE7UN7Bg+KslY6p4jMDfc9UWsuJB6CuiD9k5JyRftDMq2G9AWPiiBfqfhOK58iv
	hv1Fi9x4IYj89aILWD9NBj0pKLsUK0pVb05eB3cIM3U7cvloImuSOQcPXygnJi+94T5JVafe+Ty
	24ZF4RVuS+G37TO7M5hBQdU6T2Jnkwzb99P4C668dtTptbrKMdO93z8WaOa/1qbM9qHkHiJ/iYs
	pnJY3WN+1kCMzL586VP3oU73lOt3GDvTOUW+FaCrdD0/gNWXSQ==
X-Received: by 2002:a05:622a:6105:b0:50f:bd6d:aa2a with SMTP id
 d75a77b69052e-514d1c74edcmr29713291cf.17.1778578734644; Tue, 12 May 2026
 02:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <87pl313ni5.fsf@igalia.com>
In-Reply-To: <87pl313ni5.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 11:38:43 +0200
X-Gm-Features: AVHnY4LFFEbjeS8dhCWHmDPz0qaSyC1eBRE5sqfnh02Z5C9rnqZ87Ze4nPOvHUQ
Message-ID: <CAJfpeguGGNY-o=p-gpKx0w1KNwKfNKxKMXn2JrjsO1mJfFCJRQ@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: Luis Henriques <luis@igalia.com>
Cc: fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	John Groves <John@groves.net>, Joanne Koong <joannelkoong@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 18:43, Luis Henriques <luis@igalia.com> wrote:

> I'd like to clarify this: do you see fusex as some sort of staging area
> for features development that would (or could) eventually be merged back
> into the "traditional" FUSE?

Could do that, yes.

> I'm asking because I got under the impression that file handles in
> particular was something that would be desired to have in "traditional"
> FUSE (and that's where I would rather have them TBH).  This would, for
> example, help unbreak nfs exports.

I'm fine with that.  Especially since code can easily be shared between the two.

Thanks,
Miklos
