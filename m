Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F81519B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797889; cv=none; b=e/edmlyWLvvOws0ZHEqDqIRftPbAQ5qSGHNRSs1cpao/L+H8i3OL3uBWXLers/ghBiXBvM538wiB9w+clhQNUU39QXkZ/pF1VWj9IMWVB+97haq4pHfE8zkbxdOWiYpjwKehWGm+lromnANdC5hi0JgDi+I4FLSBJl6MNHbSW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797889; c=relaxed/simple;
	bh=sgXsN5ItagWIV69KxgSGg3f3EjuUoX/kFzlWwLW7XEE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSsvWpbOMIhRvkGQgweIh9DlMtCgIjq7jUhHjqG4GQf7gYSh/HriIYVaTfGVG+G53q37GqpZH7i7yDaJsuWeanx8k3FrRP18DpjhkKREBmDKDDc7VL3wJ41umCSVzNbPaYAKwhV0zYA2zLr5gx8ejmeLT9LB4dKuinGma4G7l6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQI8lyIH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=URlSPQGA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQI8lyIH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="URlSPQGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778797886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kzTP4aRYW6VNhsi1rfhGxy4232nO7/Aa1UyVr2mM/0=;
	b=KQI8lyIHK7XFunsqSY8DCzzbu2N95FL6ZzWs/z6Gt4/t595va+ArsdkgVbFt+lyDyOv8Rz
	FkrKdCAdvY5nZSO0f65iRXH/P/ox5jHBtrGAxCj+rORfpbTyY8bO69DuZaKg/KX9LiW0UR
	5SsgWtgauEvBPA90YxUR3Z4k+C3FFz0=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-OLVuoowIMKq81YbtU2Usdg-1; Thu, 14 May 2026 18:31:24 -0400
X-MC-Unique: OLVuoowIMKq81YbtU2Usdg-1
X-Mimecast-MFC-AGG-ID: OLVuoowIMKq81YbtU2Usdg_1778797884
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65c37eafd67so16974010d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778797884; x=1779402684; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kzTP4aRYW6VNhsi1rfhGxy4232nO7/Aa1UyVr2mM/0=;
        b=URlSPQGAXcfWebk0g5f50hGU8y5hhy0jCo/UKjUKekQWOO4w4ZctFYHetyCVPyRwLr
         CfASgdJY++xKXaipH8LzeUfOELMOJpYRXH7w1ut0Koek10VLs6YYXsgsFxd28THGoZgt
         MmUH7V31AGwPn6RAssf03PXD7gOERbKovl0zVymiygrNFYLUAWyTemhTTYs5sXZ2qZ7+
         ZgFPGbo2edi45llPW618btPGmyoq7VqK5qWn42kff3mT8u3LBMwOdon5/xQIYn5/hLpM
         gzKuMD0iIrj+oNWFwk6IfS+q++VBy4UfMu2+IG1t+EN4X8dP08MOpd4KHqu5bWhygHAb
         Pu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797884; x=1779402684;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kzTP4aRYW6VNhsi1rfhGxy4232nO7/Aa1UyVr2mM/0=;
        b=nHBsz1vFgK3iyzgMd0aVMO1jktXcoONcVA9mTwJfs6WziTcwNJ+2CqUSJHJhuYQ6sT
         u94euA6vdtKphxxurUKKl6oEDnLUo6/8MNjl8yLZSCfrwDKEYcM2SFYfc6Uo356Jdasj
         nNHeGDvqzci9w3L6jTPL12sKE5DveinZkGXzodlDfvidl+Q7JMgVwfw/y4o5yUjvw3Pb
         1RFfC/XyC0Z2lLHK2JMZkeI5ZcYGcZinEa08MGypc4I+tRgqZyEOkeCQuqMQadC9hZyH
         JdM217kTVIncmeWDTlRYzwr+7ZvZ1mhLf0gfkjpMYJeHwlkTR7s7BoFXRvpaRJOsudKD
         c1og==
X-Forwarded-Encrypted: i=1; AFNElJ8hMq1PxirYNBPxoCypruy3QDiHZ1shstVlcfUPErsth2QOgZMDICq3hCyOO8tzKYqShc1k/dBm4otPB5hX@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFG5xr31HRxU/dUP6V6GudBxQjjnkefcqH7lPmiL2mSLDEo97
	OzDjvQVr6vP6LL1z0PUKlSfe1YCKSng2M6NhumBHvMIgK8xoja6HyqM6HYSUMzJAzrWgkHJM/EF
	n2w4przdeUNz1vvNbi37Hv5n8LqGKT6KC//YOBjtF0q9O/eoclqZMGxSXoCoTt08wf9Q=
X-Gm-Gg: Acq92OEN86DNd1fg5zo/qEVLwCXMZqA0Rmo0mxAuuAHLa4Vz7q8VXICYh+0FElaHqcC
	m91Eip8luACyMZiaJT1I1KE3JvFplfA56bJDiMbplz9ymRLeXCgqz9WZ64eEyH2n+zExDWgAi71
	iWwMuePh/YRnzoc5P6uYxPld792Ee+RZ8+m5js84GpKzoZ4AjYZv1IDu/479NmX1Kl9q0/MZJNQ
	AoJNN/C4hOl0gzlMXrnpUyI/QjPBBRtZhZ4Wf3ALoDQ/FK3vIhzUcIMmA/PU4CHjuCsXCjAcRYu
	E8qUUAcxjcT4L/WyMZYnVCg6doCj/vZ+Y5XbrC/ua2UPXphsnrHXoXVwVJ3AnF04Kz196AMgS5z
	5YlnFp3ixkpTIzihQ5MI/700M8kpScRQjl5dRmyAnO1VuMebd7bMn
X-Received: by 2002:a05:690c:c4e3:b0:79e:9cc1:edf7 with SMTP id 00721157ae682-7c95ae490a8mr15455257b3.13.1778797884189;
        Thu, 14 May 2026 15:31:24 -0700 (PDT)
X-Received: by 2002:a05:690c:c4e3:b0:79e:9cc1:edf7 with SMTP id 00721157ae682-7c95ae490a8mr15454857b3.13.1778797883682;
        Thu, 14 May 2026 15:31:23 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f5c962c2sm20644027b3.48.2026.05.14.15.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:31:23 -0700 (PDT)
Message-ID: <1d34d7a30b5e33ab99b6bdef88297b540337395c.camel@redhat.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_mdb_commit
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: syzbot <syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com>, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Date: Thu, 14 May 2026 15:31:21 -0700
In-Reply-To: <6a05437d.170a0220.196691.0003.GAE@google.com>
References: <6a05437d.170a0220.196691.0003.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-13 at 20:37 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    1bfaee9d3351 Merge tag 'fsverity-for-linus' of git://git.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12f0872658000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7f195f6be48c1=
2ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc149ad75e9633be=
0c1ad
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20

It is really sad that we don't have a reproducer for  the issue.

> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-1bfaee9d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/879fc4fe312e/vmlinu=
x-1bfaee9d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9e35bd667fed/b=
zImage-1bfaee9d.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com
>=20
> loop0: detected capacity change from 0 to 64
> loop0: detected capacity change from 64 to 0
> Buffer I/O error on dev loop0, logical block 62, lost sync page write
> hfs: unable to read volume bitmap

I assume that we have two issues here. As far as I can see, we have 64 bloc=
ks in
the HFS volume. And we try to read logical block 62 that expected to have
portion of volume bitmap. Somehow, we've failed to read it:

		while (size) {
			bh =3D sb_bread(sb, block);
			if (!bh) {
				pr_err("unable to read volume bitmap\n");
				break;
			}
<skipped>
		}

And it is not completely clear why the read has failed.

> ------------[ cut here ]------------
> !buffer_uptodate(bh)
> WARNING: fs/buffer.c:1087 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:10=
87, CPU#0: syz.0.0/5321

But this issue took place because buffer with alternative/backup MDB has no=
t
been set as uptodate:

void mark_buffer_dirty(struct buffer_head *bh)
{
	WARN_ON_ONCE(!buffer_uptodate(bh));
<skipped>
}

if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)->flags) &&
    HFS_SB(sb)->alt_mdb) {
<skipped>

		mark_buffer_dirty(HFS_SB(sb)->alt_mdb_bh);
		sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
}

Thanks,
Slava.

> Modules linked in:
> CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(fu=
ll)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:1087
> Code: 4c 89 f7 e8 b9 5c da ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5=
f 5d e9 b4 63 fb ff e8 3f 91 6d ff eb 8c e8 38 91 6d ff 90 <0f> 0b 90 e9 a5=
 fd ff ff e8 2a 91 6d ff 90 0f 0b 90 e9 cf fd ff ff
> RSP: 0018:ffffc9000ddafba8 EFLAGS: 00010283
> RAX: ffffffff82584008 RBX: ffff888046e26658 RCX: 0000000000100000
> RDX: ffffc9000eefa000 RSI: 0000000000001912 RDI: 0000000000001913
> RBP: 1ffff11007a3ec01 R08: ffff888046e2665f R09: 1ffff11008dc4ccb
> R10: dffffc0000000000 R11: ffffed1008dc4ccc R12: dffffc0000000000
> R13: ffff88803d1f6628 R14: ffff888055813c0b R15: ffff888055831492
> FS:  00007f2c9e9b96c0(0000) GS:ffff88808c881000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000210 CR3: 00000000133b8000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  hfs_mdb_commit+0x84b/0x1150 fs/hfs/mdb.c:328
>  hfs_sync_fs+0x1d/0x30 fs/hfs/super.c:38
>  sync_filesystem+0x1cf/0x230 fs/sync.c:66
>  hfs_reconfigure+0x66/0x270 fs/hfs/super.c:122
>  reconfigure_super+0x227/0x8a0 fs/super.c:1080
>  do_remount fs/namespace.c:3400 [inline]
>  path_mount+0xdc5/0x10e0 fs/namespace.c:4146
>  do_mount fs/namespace.c:4167 [inline]
>  __do_sys_mount fs/namespace.c:4383 [inline]
>  __se_sys_mount+0x31d/0x420 fs/namespace.c:4360
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2c9db9cdd9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2c9e9b8fe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f2c9de15fa0 RCX: 00007f2c9db9cdd9
> RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000000
> RBP: 00007f2c9dc32d69 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000c22 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f2c9de16038 R14: 00007f2c9de15fa0 R15: 00007fffa4666ff8
>  </TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

