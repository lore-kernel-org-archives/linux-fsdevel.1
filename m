Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894268;
	b=KUJb4CxRBvnFty1h0XW4VBUZR/+1DUiaRA2RLvat20Xdowg8+NV4r5wfNlB2L90UkVO9
	 p9KW99qfCYFERLSXEKsDBCnE51gEspRAWAthGLPL7cc2XPp6WQN071Mm1jPMUrP1E9vJU
	 c7hzK385kW/kk07mkUVO16g4q+LzX1U3/afEu2C2jF/LLnm80ClrpS53LVFrKl0jkMRpS
	 /ZQ4F8fOvhBZWLSoy1dqweAA7mNPLzuk9COz/eOK8hGOkDBesT5yCD8nXerULZFz/VtHl
	 Ylu4FpjCK6KEgNFcjDTKPr39zRiMB2uLRfRcWTct3KiY4BrRSHzYj9c5hJNIQU9E4rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+QzyelSArYy7hz0DLVg2HvT3P2ld88WZrMke4YQyrAA=;
	b=LbtPokZOYvUDE9r+nm/RFLPbPGp0izsRp73WgwzJYHiMSvpUM5JXvblo9wRIkfE+XGtR
	 csYljbKBe2tmBp6FCXHYZrC42NHBGxV3OD9L/gh+eKv0//VlThmc1tKP/71X3N81KBoUh
	 13h09n4J0xUROqBtW7yx5DGQVfYuJsUwsPhH6NLkOgUD96SBMS+0+oYy0t09a6j0yIBIB
	 PsTtzYQmunFZhfphrsrXRWA+JEhZv+wuflyG6Py4BrKGMskPibLmiHkT3ZSXnV5s0hzCZ
	 +W+M3QhdffIDEl1AM6nGRAJtdcxyx05kYceAQinVfUMauXS99YdfbHke+YQHwgjSqMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7dSkidk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0D606D805
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA0D606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7dSkidk
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so112341566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793894267; cv=none;
        d=google.com; s=arc-20260327;
        b=eOzJjeaWIqCAnMRGAM6ubNKiui8YoKIZYPwmXBRRq7HQ+LXuxB3ndVOFZUYGj9QZYx
         08ku00I5irOsVJzaGSTVlHUH++tJQ6k0VUh7BbuimO5h2ghyjJD/K0vdUpR4CTUgrnad
         IzHlDVgyBmgKQO9hHnNRWU7r4Lmx9UAyD95hilxflG7ccI0p2muqPZI2rPA92/YImdFu
         wjaNNZy0eP3DIcK+k6IYWcFRDE3vCo7norGop9s+StfnZerwr4/E4wnDBIVXfIYjITvx
         9PcoUdFc7p7tZGYRAflSdGQ59yegNqZa4fGZIRpF9Ks2cb39ZgqfawSpTfh7zu57hnhN
         +EBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+QzyelSArYy7hz0DLVg2HvT3P2ld88WZrMke4YQyrAA=;
        fh=3ASeLSxn6sVwT3vnsTRHE55YX7O96bIPKLdfJKsN4cU=;
        b=FCXVpS4TxEjaYBrcNgy+vQPNSXkfgagLkUZU435x89wTi503uhqClumTrUmVEYSmTa
         zjwy7XCjb1A11kd+H83aMvy3d11URmEqsVhpf4bgICxp1/Tndx1dVx0DFSMx0+xJbkdw
         n1y0D9BS027bDs5Es4sV4ddP9DuOhgpKvsyVphc5EmK+Bb5g03mx/KbOvML+cRm172nk
         cgoAwxQUyqrgI5+Fjj0w9tbpLaF65dVRWijN37jWadWHSm4r742GsArpErSIXuENVRs0
         YXwYePu2tSBfkTJ+/1bwyw33SDBQcDZwzQ5UPsNGEJEsMNEie8IyO/mfhvKrzzm/NpK5
         42Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793894267; x=1794499067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+QzyelSArYy7hz0DLVg2HvT3P2ld88WZrMke4YQyrAA=;
        b=X7dSkidkFL66xaTqpxQSaiYiX+ka1neIyQ2xzDPUsCe00qoG8dNfvQFvW95Rno1fCu
         7U2holMfYt8WbIDfP43B3SIHwIamQbQD8tW2QJm2fDkca0ZfxOALt3u4qAil82tadsj8
         u/TRjSkWXtfDZX7yeKsCss9kVTge/QE+/9ei73snguAcoHhA/bx9PcPUs+5T6xcRCzPk
         fCwPGbAGdqqmW4INuhN19Q2edkfXGD70Yq8gLeBav+yy4gA0cbOqWCJTPWq7+6cH7XmG
         TtC4Gr+H06LY2dsyaNWNe8bAuFAK3xJQ23Phjh7LQUS5FoIzTpwmI4e652Hp51tAWoSI
         NcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793894267; x=1794499067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QzyelSArYy7hz0DLVg2HvT3P2ld88WZrMke4YQyrAA=;
        b=AnjdCj4Moi7nxZsmZHrDWpLjTLWig8MDFgKF/pP6MJ4mYXnsLbOQu7H2gih41EeSn8
         MSR5EJiyX/goAH8JV/Afn4vwBXs0s6EymyfCbVAyyFAe1ND8aAzrB7fyTS8RbNQAENKl
         lcQ6jMHhVDAbA3n8OWkwt8UtwTi/RB4dDt47ohIjpR3frUSLaRcs7JsZqETc+TXSro9d
         kLw2MVfzcjfNiUJC+1J8rp3vr/V3vFG07yWkZXDRAQvxxkWx8LDrtk3YmxRxC1it+TJ5
         IEDE+ncelEn+RUa+TdCy5C9SZbLHbuFruBeM7i2Cep4EtdZgbGQzi70ZsEgZB0gPO4P8
         9BXw==
X-Forwarded-Encrypted: i=1; AKwUvBwJsJSRL1k+RuXuWB1Fv0RMd1ZCKBTulrmcGvoyydmFeOsrKaFxt98LdbJJIKXpZxQsSg7iOY/u9c6iPSe6@vger.kernel.org
X-Gm-Message-State: APuU4Z+5PFaPS3KFXv5xsRbivWDwwNlJwkkNVL8auTI5uKsdvnfcot0K
	krH/Nq1TII8ji3UexQdZrhuDzdY9s9ciNQQZ92NbLfveA7+MG1MhXg2mA4yTcgSUexEj79kcQ0D
	2RQXmzLy7pZ0QhlXs8vVHKlOHGZXR+q6cGvAA6xg=
X-Gm-Gg: AYBFou05pJuDU2rs408sI6G+DhE70yEkiq2FTXZsGzw+gaIoT0/6Pdq5YkqXYCyOzJ2
	EkwcDf5I+yANbJARljcN4y6alH8sm712fjKuTNdIx1XdlC+WpynPIA850RMSCDoRhDceOdqNyr+
	LHgwVQiC77xQvJv6vKHcn6ijtbzd2gUORe8R7ySlkNrvjFmUHxcq8yacqxJqm3N+7gW/wq5QeLW
	fqdubxwXHZI0M4BZojmvaNrqozU6NYK8oymZbIDDSicP/Hpa+1yM4Q/1K4dhHW0ROuBLTYcCRvl
	1uHHd0WHTP92kxYCaq9tKMW99xKRk2C2mob+mQTp7vLJO7Mt/nVc25N34s/zPRZJC6pS32qhyvB
	a0bpdVAO3bRq9yAiM3FqP/GJEXCyAMNUSiZiy6w+GbrDfEMb3qlxaUR8pSykO07ftAknz2c0UHi
	8aI8+gtlTDSUKpLAZFD32tLYITAyLh
X-Received: by 2002:a17:906:9f92:b0:c41:5970:2360 with SMTP id
 a640c23a62f3a-c4ca7ad1d1fmr1680110966b.41.1793894266551; Thu, 05 Nov 2026
 07:57:46 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202611041404.befe64cd-lkp@intel.com> <20261105-trommeln-einspannen-radius-ccb4e174e407@brauner>
 <auygOHcuBba_o132@gmail.com>
In-Reply-To: <auygOHcuBba_o132@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Nov 2026 16:57:33 +0100
X-Gm-Features: AclHuK8uwevQcSqxti_mw-yTSusmg_LuBdQex7a7cWEVSFUXj3Ulzz1Lj0cR5z8
Message-ID: <CAGudoHFpNbxL13ZOWiyyLSPpmzXcB=e=RBZ8ZGk+Oc58Aad9pA@mail.gmail.com>
Subject: Re: [linus:master] [fs/pipe] f7f4665dc5: lmbench3.PIPE.bandwidth.MB/sec
 18.5% regression
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:28=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> On Thu, Nov 05, 2026 at 04:04:58PM +0100, Christian Brauner wrote:
> > On Thu, Nov 05, 2026 at 08:38:45AM +0800, kernel test robot wrote:
> > > kernel test robot noticed a 18.5% regression of lmbench3.PIPE.bandwid=
th.MB/sec on:
> > >
> > > commit: f7f4665dc520fd8bbc1db20e59945773e03744a0 ("fs/pipe: unify the=
 page pools into a single per-pipe pool") https://git.kernel.org/cgit/linux=
/kernel/git/torvalds/linux.git master
>
>
> > @Breno can you reproduce this?
> > It's something we should at least investigate.
>
> Ack, I will check it , but not today unfortunately.
>
> I will come back to it tomorrow, and until end of week I will report my
> findings.

I figured it out.

The test at hand has multiple readers and writers using the same pipe,
with 64KB i/os.

Prior to the patch each writer had its own private pool to draw from,
guaranteeing no allocation will happen under the mutex.

With the patch the reader exit also drains the pool.

As a result tons of allocation ends up happening under the lock again:

-   94.88%    94.88%  bw_pipe          [kernel.kallsyms]     [k]
__alloc_frozen_pages_noprof
     94.88% __internal_syscall_cancel
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        ksys_write
        vfs_write
      - anon_pipe_write
         - 47.46% alloc_pages_noprof
              alloc_pages_mpol
              __alloc_frozen_pages_noprof
         - 47.42% anon_pipe_prefill_and_lock
              alloc_pages_noprof
              alloc_pages_mpol
              __alloc_frozen_pages_noprof

I don't think multiple high-volume writers vs multiple high
volume-readers is a realistic scenario and I would not bother fixing
it.

However, should someone want to address it, I think the patch should
be reverted and the resulting state tweaked. The patch at hand came
with some win for throughput in one reader vs one writer scenario,
which I'm pretty sure stems from postponing page deallocation until
after the mutex is released -- the kernel prior to any of this would
still put_page on the reader side under the lock. This bit would have
to get tweaked to recover the loss in that scenario (not to be
confused with the loss reported here).

tl;dr i think this is a EIRRELEVANT kind of a report
