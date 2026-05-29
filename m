Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9A3A8734
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085726; cv=none; b=HLuEnU+RHTjKPZn3pSQBFczySMbQjehHks/Pl4OgW34tC7p4fHqATcT5R9P4XS12uNBPWGkMu854WpTdrMhL7//UQo30BfoEWpAq20aNnmXBJnZxMivFX5KERfQGkmvFWoOyxkKzRYhZzMfRDkx2A5FrhB6IBoqOjw8a6XKROyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085726; c=relaxed/simple;
	bh=N01FzKyM/oneUR/nY80hKjSqcL3euNBKYFWM4OUxW8E=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=jXJiC25jW5qg6ztDKaojjOkA76RToLxOwzQtVjchxf8NYUUuMr+oOvuik6bizASmiMwLd/Fwp+huZ0C3PsvTnv6xzde0nUsyEkPK04Hq+nC5t6mt/epHagw/UstyXavTj/mhfSXcjeT7IVwcU3DvFDIrTNrJ2NO7FcLEokzhfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq/hURoh; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq/hURoh"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8cce22e029cso17694006d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780085724; x=1780690524; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWYN1LfizB6BVQCT1KhTKUJ2V49wLv3aFdUdiKdHhaA=;
        b=Xq/hURohQJbEDZKIZKCcyemKG1bJTQ3kYXLZ13E719g4lxg4o7vOxVthghvZl0mo41
         9yiKH9xIGntFA2MdUSD2LaRK4r7/gtYvwG3jzuPv2ST7+1jSr+NZwDcF85rq9hU5cCZQ
         N+RvEEnOEjc9Iz4Ia6Qyjxq5t8dh6kp0lJrktlppiMnp4h/ClslbiXr9o2i1mI3icvyG
         neDPjDXu+mQKp1gaoUJHvEEUciqClFE7EVZY/pP8bzBdRHulGrNIKa6nDUWXfGQVWjmn
         8Tbp+h0U0whKAKUXlN5uPqYX17JNLUwUa1JghkBKkzEqxb3jFjKjtkA959/KwJL9zqHY
         qDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085724; x=1780690524;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EWYN1LfizB6BVQCT1KhTKUJ2V49wLv3aFdUdiKdHhaA=;
        b=QfZRgByNLTlAlD7pe8DmVwHRylPG9WbZ/FJZurOMiaf4Yqk+DgJ++AmK+mvcGsiq5N
         otY5jZODYOMNaPkT+bhxSCAb4o/oI4jty2JVTWXj70znsl2QYKw6IF+ZPBlUWh2O6DXZ
         a6OiCRIzHoqL193KPmuuhVnNcEty1B5WHUNTaNi8g8vlTDaRFZ30zBLM/MtjZsK0XrDD
         a4S9F7R98S5vxUWfXC5NSyWDoVmpf3JqBk2bTd+9aFXkMosvQNILpEMI4vwbu1N/eKHF
         dwwNjYobXiN/Kyj6wH8PiMYVN9l7b7vIdshEgm4cELLxC55VQfHNYiOJVcJMPTr5a1hy
         4xBw==
X-Gm-Message-State: AOJu0YyDwKDnVdcQfSJBD7rietsyIZPYZlLBjvzJy2Wgx0Gg06d3dwa3
	rk5zsvszp6brD66sBiwFIR960mkUsRP90QXeKJzLNmviE9qdxpae5oOJ
X-Gm-Gg: Acq92OFQ4eoUA+I8IGjbrppccyR9VR3TOyrbXUgRmPJ6yjTOQ3edepZFSx80REabM+Y
	iPb8UbmUu4zrYgexEh9P5F+wrVJHGQAqyh+FYbpCN03+d1pYjEgOYZA6zVlfY7atSb57J1e8ysk
	rj6U6WjyBvyCX539RISRDQ4NGHgHX2GAkjcA1iKBy9U9LR5Ha4BmF7wDenbMnrWK5Dn1lUQVSK1
	AjBJ8UuPqk+Q7gqXN9fnHwXYDoid5P8aX5qAsbaaEMSFoJaLBSrRPMCeoElLkdgszoYWgKi3uoM
	uLiUDjaNjK08rAZWA2rThVouZcYNzkQYQZyhdB+af33QIFutwJEfkwfj4KmG8Pe2nNJWhLjXueh
	8kttiHT+VxdS8uTkW/HMVDSS9JLND8W0EJR1cG9wX7gH306dnbcro7BDKn1i6z+QBrLvfGoPKK4
	4NDfjuBXfL+1meRmgPuTwJ123r2XG0Qv64QXUSFRQIVxG1oYdBKpHlRw==
X-Received: by 2002:a05:6214:2508:b0:89c:ac42:e119 with SMTP id 6a1803df08f44-8cce4afc85dmr60314586d6.8.1780085723738;
        Fri, 29 May 2026 13:15:23 -0700 (PDT)
Received: from smtpclient.apple ([104.39.165.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0663fesm25924926d6.14.2026.05.29.13.15.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2026 13:15:23 -0700 (PDT)
From: Shuangpeng Bai <shuangpengbai@gmail.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_BFD48016-EA8E-431A-BC6B-A8095D455012";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] KASAN: slab-use-after-free in cdev_put
Message-Id: <EDF77EB4-909B-44F6-BEA3-0D111F76A5CD@gmail.com>
Date: Fri, 29 May 2026 16:15:12 -0400
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 jack@suse.cz
X-Mailer: Apple Mail (2.3864.600.51.1.1)


--Apple-Mail=_BFD48016-EA8E-431A-BC6B-A8095D455012
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Kernel Maintainers,

I hit the following KASAN report while testing current upstream kernel:

KASAN: slab-use-after-free in cdev_put

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/8f7dd0c0b1c638482b0e4cc62c554121

I=E2=80=99m happy to test debug patches or provide additional =
information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>


[  133.746964][ T8494] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  133.747541][ T8494] BUG: KASAN: slab-use-after-free in cdev_put =
(fs/char_dev.c:361)
[  133.748018][ T8494] Read of size 8 at addr ffff8881066d7108 by task =
bad_nvme_io/8494
[  133.748544][ T8494]
[  133.748716][ T8494] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.34
[  133.748718][ T8494] Call Trace:
[  133.748720][ T8494]  <TASK>
[  133.748721][ T8494]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[  133.748725][ T8494]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[  133.748734][ T8494]  kasan_report (mm/kasan/report.c:595)
[  133.748738][ T8494]  cdev_put (fs/char_dev.c:361)
[  133.748740][ T8494]  __fput (fs/file_table.c:513)
[  133.748743][ T8494]  fput_close_sync (fs/file_table.c:615)
[  133.748756][ T8494]  __x64_sys_close (fs/open.c:1507 fs/open.c:1492 =
fs/open.c:1492)
[  133.748759][ T8494]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
arch/x86/entry/syscall_64.c:94)
[  133.748761][ T8494]  entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:121)
[  133.748764][ T8494] RIP: 0033:0x7fd3713a311b
[  133.748767][ T8494] Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 =
00 48 83 ec 18 89 7c 24 0c e8 f3 fb ff f4

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 05                	syscall
   2:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   8:	77 45                	ja     0x4f
   a:	c3                   	ret
   b:	0f 1f 40 00          	nopl   0x0(%rax)
   f:	48 83 ec 18          	sub    $0x18,%rsp
  13:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  17:	e8 f3 fb ff f4       	call   0xfffffffff4fffc0f
[  133.748769][ T8494] RSP: 002b:00007fd3709b7e60 EFLAGS: 00000293 =
ORIG_RAX: 0000000000000003
[  133.748773][ T8494] RAX: ffffffffffffffda RBX: 0000557a0cdd5390 RCX: =
00007fd3713a311b
[  133.748775][ T8494] RDX: 00007fd3709b7e80 RSI: 00000000c0484e43 RDI: =
0000000000000010
[  133.748776][ T8494] RBP: 0000000000000010 R08: 0000000000000000 R09: =
00007fd3709b8700
[  133.748778][ T8494] R10: 0000000000000000 R11: 0000000000000293 R12: =
00007fd3709b7e80
[  133.748779][ T8494] R13: 000000000000010b R14: 00007fd3709b7fc0 R15: =
0000000000802000
[  133.748782][ T8494]  </TASK>
[  133.748783][ T8494]
[  133.760567][ T8494] Freed by task 8494 on cpu 1 at 133.746963s:
[  133.760976][ T8494]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[  133.761296][ T8494]  kasan_save_free_info (mm/kasan/generic.c:584)
[  133.761651][ T8494]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
[  133.761976][ T8494]  kfree (./include/linux/kasan.h:235 =
mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[  133.762243][ T8494]  nvme_ns_head_chr_release =
(drivers/nvme/host/multipath.c:606)
[  133.762617][ T8494]  __fput (fs/file_table.c:510)
[  133.762889][ T8494]  fput_close_sync (fs/file_table.c:615)
[  133.763213][ T8494]  __x64_sys_close (fs/open.c:1507 fs/open.c:1492 =
fs/open.c:1492)
[  133.763526][ T8494]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
arch/x86/entry/syscall_64.c:94)
[  133.763838][ T8494]  entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:121)
[  133.764235][ T8494]
[  133.764398][ T8494] The buggy address belongs to the object at =
ffff8881066d7000
[  133.764398][ T8494]  which belongs to the cache kmalloc-2k of size =
2048
[  133.765325][ T8494] The buggy address is located 264 bytes inside of
[  133.765325][ T8494]  freed 2048-byte region [ffff8881066d7000, =
ffff8881066d7800)




Best,
Shuangpeng


--Apple-Mail=_BFD48016-EA8E-431A-BC6B-A8095D455012
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCA0Qw
ggNAMIICKKADAgECAgpzxoAcnO02uUeSMA0GCSqGSIb3DQEBCwUAME4xFzAVBgNVBAMTDlNodWFu
Z3BlbmcgQmFpMSYwJAYJKoZIhvcNAQkBFhdzaHVhbmdwZW5nYmFpQGdtYWlsLmNvbTELMAkGA1UE
BhMCVVMwHhcNMjYwMTI3MTkyMjIzWhcNMzEwMTI3MTkyMjIzWjBOMRcwFQYDVQQDEw5TaHVhbmdw
ZW5nIEJhaTEmMCQGCSqGSIb3DQEJARYXc2h1YW5ncGVuZ2JhaUBnbWFpbC5jb20xCzAJBgNVBAYT
AlVTMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjjDmy9pLRbIcAP8+e9d3OiNLxzrk
UlSmVx67fdvsrK2abuHnKV8tbkMaVShNrFoAZTfgXbgOca5JZEzxUNnvZ8wSJVxa0fsbp1b9zPYk
PM9GHASgMdIGMNRItx60UIOxO9mLWqvdVUJs48N1QQnaUONr7w6sLdW8/Sdh/XgZUI5d4CUbORGw
cYOJgneYMtLlafzMMLREcg2qnEMOX0kiDqs2YCcRDXaU/AMs1GVbTRuGHunaCafUX+2pNWPW54om
HukRDtbnlF9uSIOuRKMd//W342ivdQ+4PBA1iz0Mg9slJ+NIlHA62Hro2JmAMtvyvLirkGS8fCb+
KL/AvGRPRwIDAQABoyAwHjAPBgkqhkiG9y8BAQoEAgUAMAsGA1UdDwQEAwIHgDANBgkqhkiG9w0B
AQsFAAOCAQEATyV/HKQD+haICrFpNql9ZvBqzFzqG/SJ/cb4ckZNxoLvGRYqz/0Hy3VhKv7nL9DO
/cbOYT0LIdCZOUwRhuOh6WrAl4ODvMYuyF51iQZ02C6tWBi0Z71Y2bZXUd9Ro53bLG+266DsdVl9
NaMtwFc2s4Qyd+BpRWL5PMcYJ0wNaUIU0LkLMK+t0JCKaDV0ezjfByKBIAsWL1HHTA3jCjjo4kUD
Op5W56Am4LpPJLVW4ASDMYdDlvyvQ4Vakdzplvt+T3QUezVAw4UBVU8d5lBr24mU6egcbZGP5dEq
ABlFtrTpnXwTwEQRBLOfQq94n8hqwbq6TMi9Sl06KU+iVIYjVzGCAfIwggHuAgEBMFwwTjEXMBUG
A1UEAxMOU2h1YW5ncGVuZyBCYWkxJjAkBgkqhkiG9w0BCQEWF3NodWFuZ3BlbmdiYWlAZ21haWwu
Y29tMQswCQYDVQQGEwJVUwIKc8aAHJztNrlHkjANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyOTIwMTUxMlowLwYJKoZIhvcNAQkE
MSIEIOLYQM6yFXO+9EeQP1hJq3b1xn0OBMZKUErf64OddEh7MA0GCSqGSIb3DQEBCwUABIIBADnL
jfQ9ZEACiUdMB4EPuQtuXQ3mbRdPFlZaIBweAmtQUnCDN+tWRrfrkNo+l5OJ8EdAAxwqOEKrFZDB
LbguCkWcKV6DV5x5hygY4JEWvAJM3M/82t3MNSvO9u+cK4pfGRsMqFK6mZPXCKfR9YX1S3vKf/79
nhbOBnGBX+yV6i43RoFLPdSKqjqr4Mn4JIdzuGBXMp4KkIY7mydMnQL1OtHS1YE13FS7rx3Fy7tS
SEjcoo+i0A4tD7eqmHdNeeIJZTZ+wYBZ7wXNYZtcKdz4BhcGQjdPLvda4tyeh+u033lqWn5yjmoh
twzsbGv+EOA4wCQyfqzXShWdgkMpn5sYUWEAAAAAAAA=
--Apple-Mail=_BFD48016-EA8E-431A-BC6B-A8095D455012--
