Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838F37BE7D
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304440; cv=pass; b=FyZ4d7yyU2wfnpTK+fTdgoKd347pf7bxYa/Oy4364RD4Uigmifn0emo+DmfOW0FEetf4YtFnFedK/J+qjEBfI4mUZGT47RdmGUirecNZ/c+VdICcE+NW+Xg0+CyZLojbDzGzWOQnWDy7CueJYQ6yfmIlG8tBfmTVqHvsSpqqv2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304440; c=relaxed/simple;
	bh=DgzsF0b8/ammgmq5bjSdH0azN79qHDRIyckReh5EH50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqnNQOhsMwD/mY6NLI+qvs8AKpHbRuPRjaTdt291IBkLEKl8DHR7KFFkJ4LUptiPGX2MP7zIaMv/eRKT8psNEsD1NDnkP0JvMZbk5mdJNnkaA89ssJaDAyo/gLh6L9lYStDkc/IKobSiFAkbixDEE2jqVQFBxnxDClA7E0d6UP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp9javvx; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp9javvx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec201b582so2579530e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 19:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783304437; cv=none;
        d=google.com; s=arc-20260327;
        b=ktuFmRWiFfrKNNJY4Iyp0PYkkmRgDIRasCwvz8d2D+GVrAyHiuvJlHPBfuT+BxgBRi
         sJQjxWflI+QncH9QCv2RPDR8jzi1lr2g/3gvjpPF1XQnLcLcOHGN6jw2w7LjYnq6V2q2
         r+dBw3T4qNB9x1Jb/XSLH6vGbX0BQkI4UoLVKXeqHay2c0SN45D37IoWE+27d69fbOVy
         c0J1fipFFvR6Lf229xzQSPQ9sIelia1Yb+TRheKHMefhAMrZD4JskD1x0NsL6//+qNFB
         Z357RJayeuTH5zaXInoPQg3hI/RQ84aCAlvkMFMRUPISpO47gLshoVZfErpHD6E7f6WK
         OTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z4YUa2YRVjs9VvwkcIvLVBsRAhUSH+1Dac1kZxht8Dk=;
        fh=Jl1+IW0Bk5vpw7UqL+8kpk5iKL4avF92LazrW5dBBfI=;
        b=Odf7iLuBIdc6+4JAukCBBhkiY9paQrxWJbTPwqaGml4h6ZwYeQHaNh5YuoQePvR4TZ
         d8lRGGmOlQ8EE/Gndt0jBvqYDoJkIJLo6l3xxvGhQ08Tv/sFEbBCInzSdifXIrbk0hd6
         KaS1yqn5Zo/H0BCXgDnIyss/ApKcSXvZCGVJ5+t4d0AE18hd1S6cHcC1rwakbG4Ye5hg
         1+/k6txs8mfOhpeneVK4nYwTlHwAkVkjXCrUFJHmIpWRBASzNqH+14mxN3c5p5SED0X6
         MujMdEDPs2aJXsHO4J+XRcc5LXP+5k8b9MedRQV9iH4pXwaDLOaNWejiPcObqrcVoVmJ
         4mrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783304437; x=1783909237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4YUa2YRVjs9VvwkcIvLVBsRAhUSH+1Dac1kZxht8Dk=;
        b=Pp9javvxqU7/RcIdQLrldbLNd0gK1qxtaoDP+aSF3qEKHS333uz29aYNZdlzrc6KzX
         TmHGFZggQ88qKTkkEi3dTh3o5SRG7kl6KgXH/ic1giKxm2JBZTEYsi4Hk/79sp910WH1
         G+TvMmVUlV3qIg8mDSNv2hp4hBpph3Bk6W2omtlTTr8AUdo8d5rhoE5UBI0/Iv1jW5z1
         7DbOqeRJ3q6EvbGrrcSY/lPDELgRFy5l+nqcV047oIt0uMiigRYxKLQ2IvyZRA38z4Bh
         +j0smj8JmciNSXIlRdzZYNnod2Gz1jJK17rCZahTJn3hGvuhlRtRVae88UyoEpabnAA4
         te8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783304437; x=1783909237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4YUa2YRVjs9VvwkcIvLVBsRAhUSH+1Dac1kZxht8Dk=;
        b=GG6eM3Qi/gQ6JbRpAJpgpVI6ntn+hrJM5V/HFXXGtGjMEVvuzIT5ELxriqpHdgjq8o
         Tx66zJwj26SGdbZtwxY18ymUdVFyz7L/zFtKTGR5ZgDAoRQn8T6x/C27Ibkv4XTKppFu
         omws61ZqVPhdRFXy0ThmcxOJKyT5DoK/3VpbDUt4aMUR56jvBUk0jQ4IqzeYzv7i7W8K
         CqPKsa2g72NW+9L6kbw361HQFqJFspe3vbzD8sut01+rK3MA6b0d3POfdNIQ+9yqUmSC
         pt/QATC8abeAjyiybBjeYy5WuDVnt5vrbtTibPEk9+tjV+pKsB3+tYGmYB4og0fAiNmY
         WBMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJHppCV7q6DIxNeXybH4423xplZiewO+qp7PmzD1PRWLjoq6/FD7gfj+1touiwAAhOvBBc63XkS/Nu5rIv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15rD2eFhcEMnFSNfCakbZOgxl0t9W0D3X5mMGeDaC6EAtNCyy
	NE9+8X4IFaYXDxd2StjhPUKws0JE8PksSXMbGLL/HZShzMctHmUmG6GkULc94Z61lpFtMJ1tuib
	KFZ0lS0W7TQUPHhMtdC+M5Ids1JC425w=
X-Gm-Gg: AfdE7cmMXfqjjFni4hnFI6XetDp6CW7mRNXOIGgoiCIhccPEL0buyTRajAYRHVSFe6M
	+9JFfP5B4r8uFD6xUN1RqnV6aOFgTlX+jMBgtIlbkXfHavaFmX1gCaVL6TmGoNpQQMFor6r+Q1a
	b5ypuMdDWUUCoF+EtsaGNh+ueE9S5L3qmwZFIV06rFmwosUWQ8eajJqdDMpJT87GMe5nMSSbk2V
	hecXGQoYhj/H6ah3r6SnDetw+DhbfX70/8obfCJEvEdGhFzHglreWXIsTB69P9KIZUBJIIu
X-Received: by 2002:a05:6512:3990:b0:5ae:b88f:311e with SMTP id
 2adb3069b0e04-5aed4f8090fmr1329444e87.15.1783304436650; Sun, 05 Jul 2026
 19:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702161710.2606853-1-zzzccc427@gmail.com> <CANFS6bY-GKojmuLMRKoh9r83iHT7_wQQM=SKZH3vB88QFzg11A@mail.gmail.com>
 <CAFRLqsX6CM1D3F4AvYSNj3rT8YbOn2Ah4M73B0W1FCUVNOdj3w@mail.gmail.com>
In-Reply-To: <CAFRLqsX6CM1D3F4AvYSNj3rT8YbOn2Ah4M73B0W1FCUVNOdj3w@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 11:20:24 +0900
X-Gm-Features: AVVi8CfbV25k2EwS-o7WswJXBUu8J59l1licQmKFtB_yu3_6YOmZEy4NN0BrGyY
Message-ID: <CANFS6bZY3yfocFbAyg2FQqijQ4jjyXA-fprE-eQMcU5xKOS+eg@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs: serialize attribute-list replacement with lookups
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 5=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 12:40, C=
en Zhang <zzzccc427@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi, Hyunchul
>
> Hyunchul Lee <hyc.lee@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=94 09:41=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Cen,
> >
> > While running generic/013 from xfstests, I observed the following hung
> > task warning:
> >
> > [  492.533956] INFO: task fsstress:934 blocked for more than 122 second=
s.
> > [  492.534445]       Tainted: G           O        7.1.0-g81fe702ff176 =
#2
> > [  492.534870] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  492.535914] INFO: task fsstress:934 <reader> blocked on an
> > rw-semaphore likely owned by task fsstress:934 <writer>
> > [  492.536788] INFO: lockdep is turned off.
> >
> > # ps -eo pid,comm,stat | grep " D"
> >     460 kworker/u16:4+f D
> >     934 fsstress        D+
> >
> > # cat /proc/934/stack
> > [<0>] ntfs_attr_list_lock+0x2a/0x60 [ntfs]
> > [<0>] ntfs_attr_get_search_ctx+0x97/0x100 [ntfs]
> > [<0>] ntfs_resident_attr_resize+0x64/0x610 [ntfs]
> > [<0>] ntfs_ir_truncate+0x82/0x120 [ntfs]
> > [<0>] ntfs_ie_add+0x35/0x200 [ntfs]
> > [<0>] ntfs_index_add_filename+0xca/0x120 [ntfs]
> > [<0>] __ntfs_create+0xa9a/0xd80 [ntfs]
> > [<0>] ntfs_create+0xbd/0x170 [ntfs]
> > [<0>] path_openat+0x1014/0x1400
> > [<0>] do_file_open+0xdf/0x1a0
> > [<0>] do_sys_openat2+0x7b/0xe0
> > [<0>] __x64_sys_creat+0x45/0x70
> > [<0>] do_syscall_64+0x101/0x6a0
> > [<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > # cat /proc/460/stack
> > [<0>] __ntfs_write_inode+0x7b/0x6b0 [ntfs]
> > [<0>] __writeback_single_inode+0x3f1/0x580
> > [<0>] writeback_sb_inodes+0x25b/0x8c0
> > [<0>] __writeback_inodes_wb+0x47/0xf0
> > [<0>] wb_writeback+0x216/0x440
> > [<0>] wb_workfn+0x3e6/0x510
> > [<0>] process_one_work+0x200/0x5e0
> > [<0>] worker_thread+0x1a0/0x370
> > [<0>] kthread+0xef/0x120
> > [<0>] ret_from_fork+0x270/0x330
> > [<0>] ret_from_fork_asm+0x1a/0x30
>
> Thanks for the review and test.
>
> I tried to solve this crash, then kept refining the locking after testing
> it with xfstests.  During that process I ran into more and more issues,
> which forced me to keep changing and expanding the patch.  As a result,
> the current patch has become quite large and complex, although I have not
> found new issues with the current version under xfstests.
>
> However, this version was also prepared with LLM assistance, and although
> I reviewed and tested the result, I am not fully confident that this is
> already the best or complete solution.  I am therefore sending it as an R=
FC
> first.  I would appreciate your review on whether this direction and lock
> ordering look reasonable, or whether you would prefer a smaller/different
> approach.  It would also be great if you could help solve this together;
> I may have made it more complicated than it needed to be.

Could you summarize what issues were found and how they were resolved?

There are so many changes in the v5 patch, it is difficult to understand th=
e
overall picture.

>
> Best Regards,
> Cen Zhang



--=20
Thanks,
Hyunchul
