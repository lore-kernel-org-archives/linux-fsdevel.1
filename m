Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89A379C5E
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783180013; cv=pass; b=aPSG50Nt4/6FjcuOOwng5mS1MxX1U9Y1o6IAVf5dDeSLQ86o/pK+7lHmusgH4mL5OBNhi4ddBtfJ+ne07yv5cfDdOxjaJs5RNDr3ED0P5HsOCU9HLHl1Es+L+qJgyws9hlSJYNYc9x4BclFKlJHa44QYH+P86tGqpO1Cx0RH6LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783180013; c=relaxed/simple;
	bh=cgBaoxyiObdfUVqeVAH++A5XNz3ZbZ97NMrtgp9Vnac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjYeIAoVnIJ33zl2htrRUQZrjSlS+zv6lBfzVH5qLm+/FRHYlh0SfvN3Z+MjWAJbl55wgPgaAVsyaY9/w9+gQc7+qdmGHNgjMhwbNXnzXYzwVIQs5m5R9iV4/MUfyrK1hsZeClybK6FuI2FBlm/JG7Z6Aj/12cyfoJaxTcRYh5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDAiyleg; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDAiyleg"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9696570e34fso1088398241.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2026 08:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783180010; cv=none;
        d=google.com; s=arc-20260327;
        b=p2hmvL9RrmcNr9U3zhpvNgF7lC3hS7EGfOTkqIdCSYwUCcvqsmFDZwMIykO0+XoymJ
         TdCG+rtZjOsPAvGALujKABYSIwivMNTKDQPA07bUr3FZraGjarStHpesgn4tzt/P0inY
         EKxH+v+kh6qLN7R/wyjEWIh2VgzNAF8N4FgOIYaTmgOFVeP/J5stq5N9rOtqGKFufEeh
         D6gw+IjhXHZWXHJBcxIbAA2Dt+CFEgC2MjHCUD9DYinQquSSgmWJ6XpQH6CSSzx+yoS2
         A0AQBlTgZDBNv6X2ecTa+ifEZbWiPTcUTPknWNgw3c+ELgxIv2BRKuhnNTcL7Xv3kkr/
         tVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pANbksp+ZiawQpzxWOX+bmT/yeRrApX59wkeUxgkzQ8=;
        fh=xb1soKA3Yw6wtrjpqkDGUTYZ5EWB2g9PpB3jr2Qm5aw=;
        b=QzbMMoQXHqZ/X4Wg3mNVG+H5tKB2NUVYneRs1DmdmZwHSE3hNXQTFKQZXNmTeAhH4L
         0GQUUaVJbr8UAplkKbGNHKcEh9TgBDWXiXFds+FSgYYYhwdN4lvFSxjy7+2qNek2+fR4
         b31p+vq0TtyPN6aeLLYKmFQBuPbfGTxaEf3UcuGcb4pWKGbhw3wnnacYehpdVcQpXCjX
         bhQQyB845qHwAokvFmbxo6pnRtUl+t3ChovoMwDYdYtNpl8Xuh1UEh+cPixFUd2QJ15Y
         lC+5y0JUA5Nr2+a+svWBu1i4SKQTpfjZvhewR9VIz6v8TMY25utZd7p8jBHhIIax4oLF
         Y8gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783180010; x=1783784810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pANbksp+ZiawQpzxWOX+bmT/yeRrApX59wkeUxgkzQ8=;
        b=UDAiylegDTG9/13N6Ew/tyB4q5QDAeV3ZuzL84XwsDPJOMuVsB1UHYwLTp8CRCmGDb
         sTmxIj99L+QHF9ax76VPV4pK7hL/lYQgToTkbYMYDx29SE+sROb/NmVIpgP7niVanjDj
         kuM6kpNZzNej72cUebANkcq2IreUIk3M0grIYDOlUF7aohcc1ZkLUM6FwAsIgaIJVxks
         lIFcz4/WmrpIhdArIT2okAaQ2anh500C/PQQjWYPyqwiefC4daFggx7Y7r2ouJH8G9V1
         6XFbvm0VBJrWhHHm7fcjuoAHfuAaMRA+EEWBKa+GDUPBw9ILuRlRxOR/JfYBdFrdeJn5
         BfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783180010; x=1783784810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pANbksp+ZiawQpzxWOX+bmT/yeRrApX59wkeUxgkzQ8=;
        b=UqspJJIb9QK434VNkZHnOWzmkvP6AsnKYcsbSnUCCm3kMwfbNiUf8hzvnbQOzz2ZfE
         6O1eYvM/VoqLQ3Px5bFHT5rDWVYEPn11asX47wI0JNZMUmtMuIrFl01JwYEHnNDYq0e9
         yw+QHvs91I6fbXdVLH0vyycZ/HdncmRDBAXZ0FyH1cThLgHLQ9gkYG5b4YH9o/jrKgpO
         M/xhKEN+otBybZQw81NbDrWSSIlzLWx99ZCqNM4RKVoLg3k1ibKhI5RpKlIX0x5Zk1Vk
         dVHbzQ9df3vcVOGRog9D79rPkXRZrbIdg4ANT3MCv29KPOnDzzMQhBck16LBJ7IgyzpR
         uF6A==
X-Forwarded-Encrypted: i=1; AHgh+Ro1DqO5/lSDoCe/v+yrcooNw/HiNhaYgPyJkmfkDBi8J407c13m4MYNPIlJGnsUa7f682aLKcwg1qGrnN2p@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdVAAzKXwpzF7KUWJdroHrEo9Auab64vTit5UH9PNIvfliqT1
	C3cs/jgrZl3A01njd+EE9RkKUaLNaVTJC/QTLmFzJjF29Ok1NioFZVNY6G1u8n5xCkGJMWWRfC7
	zr8bKEGP5NUWR+ng2ZpquvADAtilntf8aSj9C/gmwsA==
X-Gm-Gg: AfdE7clatZlQQinASDqa0IxqwZZ6tCDD4phLcQ6GPTkJG0YCG+MH2wju8zVAhOd+VV2
	ak6ZdmlabDXHzo8b780jtJSuHB3YMOk3EdabiTppb9HrDs0N8SVLOXJAoKbHdevqzco2FV0WHDs
	iwSebNHm3ygfefwIJOeF+IVPL1BnkAoUVvwryxTg6BxnFSVFgu1tOONrdCSUVaw1Jkhf01JpYLl
	RpyUkKZTQMABKC7/ooKnA0conE2zeiWGT0dRZZkYc6yqQGP3pDp8ZoEZ9X7wrP7AxuL+O9LBhYM
	Eswznn4+gw==
X-Received: by 2002:a05:690c:6184:b0:80b:aef9:bc12 with SMTP id
 00721157ae682-817442169fdmr35132077b3.25.1783179605035; Sat, 04 Jul 2026
 08:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702161710.2606853-1-zzzccc427@gmail.com> <CANFS6bY-GKojmuLMRKoh9r83iHT7_wQQM=SKZH3vB88QFzg11A@mail.gmail.com>
In-Reply-To: <CANFS6bY-GKojmuLMRKoh9r83iHT7_wQQM=SKZH3vB88QFzg11A@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 4 Jul 2026 23:39:53 +0800
X-Gm-Features: AVVi8CfS1nbxamMPTZo20QaMYj82ym8W6BZyWAv-sIBzEyp5oEJm44cr4_UlM_Y
Message-ID: <CAFRLqsX6CM1D3F4AvYSNj3rT8YbOn2Ah4M73B0W1FCUVNOdj3w@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs: serialize attribute-list replacement with lookups
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hyunchul

Hyunchul Lee <hyc.lee@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=BA=94 09:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Cen,
>
> While running generic/013 from xfstests, I observed the following hung
> task warning:
>
> [  492.533956] INFO: task fsstress:934 blocked for more than 122 seconds.
> [  492.534445]       Tainted: G           O        7.1.0-g81fe702ff176 #2
> [  492.534870] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  492.535914] INFO: task fsstress:934 <reader> blocked on an
> rw-semaphore likely owned by task fsstress:934 <writer>
> [  492.536788] INFO: lockdep is turned off.
>
> # ps -eo pid,comm,stat | grep " D"
>     460 kworker/u16:4+f D
>     934 fsstress        D+
>
> # cat /proc/934/stack
> [<0>] ntfs_attr_list_lock+0x2a/0x60 [ntfs]
> [<0>] ntfs_attr_get_search_ctx+0x97/0x100 [ntfs]
> [<0>] ntfs_resident_attr_resize+0x64/0x610 [ntfs]
> [<0>] ntfs_ir_truncate+0x82/0x120 [ntfs]
> [<0>] ntfs_ie_add+0x35/0x200 [ntfs]
> [<0>] ntfs_index_add_filename+0xca/0x120 [ntfs]
> [<0>] __ntfs_create+0xa9a/0xd80 [ntfs]
> [<0>] ntfs_create+0xbd/0x170 [ntfs]
> [<0>] path_openat+0x1014/0x1400
> [<0>] do_file_open+0xdf/0x1a0
> [<0>] do_sys_openat2+0x7b/0xe0
> [<0>] __x64_sys_creat+0x45/0x70
> [<0>] do_syscall_64+0x101/0x6a0
> [<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> # cat /proc/460/stack
> [<0>] __ntfs_write_inode+0x7b/0x6b0 [ntfs]
> [<0>] __writeback_single_inode+0x3f1/0x580
> [<0>] writeback_sb_inodes+0x25b/0x8c0
> [<0>] __writeback_inodes_wb+0x47/0xf0
> [<0>] wb_writeback+0x216/0x440
> [<0>] wb_workfn+0x3e6/0x510
> [<0>] process_one_work+0x200/0x5e0
> [<0>] worker_thread+0x1a0/0x370
> [<0>] kthread+0xef/0x120
> [<0>] ret_from_fork+0x270/0x330
> [<0>] ret_from_fork_asm+0x1a/0x30

Thanks for the review and test.

I tried to solve this crash, then kept refining the locking after testing
it with xfstests.  During that process I ran into more and more issues,
which forced me to keep changing and expanding the patch.  As a result,
the current patch has become quite large and complex, although I have not
found new issues with the current version under xfstests.

However, this version was also prepared with LLM assistance, and although
I reviewed and tested the result, I am not fully confident that this is
already the best or complete solution.  I am therefore sending it as an RFC
first.  I would appreciate your review on whether this direction and lock
ordering look reasonable, or whether you would prefer a smaller/different
approach.  It would also be great if you could help solve this together;
I may have made it more complicated than it needed to be.

Best Regards,
Cen Zhang
