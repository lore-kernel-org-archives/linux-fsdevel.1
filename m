Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003B3C07A
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532164; cv=none; b=HejZC5wGz2S2Cur64USIyinE9FJ+mVcxOKDtAR5zj5qOvAXMEu+SODOiddd19pnlYNdHP3EwEta9V/olIwg5ZkKH44IRA7GyXxGc+KqYoXJzELhZJ+uPW6N36b/MyOAYtcgmdMU3Ol7i/My5kNBKtmMgdjSAhWXEDUqmLrNMSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532164; c=relaxed/simple;
	bh=xjO/gCd09z6XgJu9G0zdXdZguLTP7idY34J/kp/cQ9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0D0SQDGRzp7ztEYDD50nZg7KqDp/h67ZQDDPbUl2P4RV2/keA+EVlyNPOj5TMYwcBQMAQNrkFPe+fWnUqfTYnd1Ax1XISwp+aD5y88J1frovGFB5wdVAoDLDPzWF02l0KWERn0Vt3pvXfTXnNFYFFR40fdcz/jcKBnL8ApmqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNfcTCT3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNfcTCT3"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8453427d3f4so8895315b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532160; x=1785136960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7evhk1CV7cA+xsAruq0KNhp2JKFmyflz2dvKT3UOV8s=;
        b=UNfcTCT3mHYtahFBnhzAQUY3CL8CIiQ/zaS2hPODlPSnc3nieEV6NfWLP+c6Nzs/fq
         f9x7Apm3dUlUCG+FYdrAJnWe4FzQMJHuBmgAeYLs3s2hRy+O6dzbS7+n7gWnrJo2+66V
         f4x6zhvCh4sjixmT+kIgh+kw1rSQR0zV5f17BmAW8hFfu34z7xNmmuM+nezwm0QGbHpx
         Cn3E2AAzJb+Ju+tIXp8PsegB/+Y+YlCGj/ioqHBOuxS/PPwoTJL5m8rAuhEEfbF/fJLP
         Gq94ti9j+Ueu8APE7HaIIM2vqlSqCqUnqNz/hHbDmNfJ4si0Dzpw/q/loJpEffW3LoH2
         HtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532160; x=1785136960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7evhk1CV7cA+xsAruq0KNhp2JKFmyflz2dvKT3UOV8s=;
        b=geirUYYKwU0y/StgT7gWnH7OZveAylhfv/5vCfOewyVSM9aORLbVvcCEnkhvlB/AJk
         648CBhsGMdwuHj9p5lFMi90MVA5yIsovebDGE70HJSn6K4lNHzcnMf7qfSEkkJhaJr2N
         T9NWyl+l7bgwdjAit9tj3xdwotOQ9jBBER/p/GdLiTgPMnZ/Rx/XkeXNRyfnjk8yopS8
         eW82r8nki5Z3br+vcfIRQJBpXhBwbsLjWG+FGp6e4XCR+vpk9DLnGiwteqBZXkzC3y5J
         jF2LftOteB9XvWVHBGsIlqJnWC+Xb7NkAjg3XaXnYGFjNoYPcx7IesQ2NcCFGS0HyJcG
         iPzg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5+nCzQE5QwQ0HlikaTUjTEswkHxvRsm+BWoUk8L1uf+9/y+riVrEYoK7Q+44kUF8leTXDNqD7n5l46hZO@vger.kernel.org
X-Gm-Message-State: AOJu0YxmhVdRfZ1XSCOqg/rrcQ3sR/22mOd+tqEoeIEW6gxk+3sBmzW7
	qE1GBfk1zFRVYbGlkAQqv8uF7Mdj0BIHQwk1i65syyRhKlYYg7WFCAEg
X-Gm-Gg: AfdE7cmHXl+DXVzlUuq9JJM3ay9ZO+AhvaZDUVvIzutsaCKkhnnHYEARS8ez687j5eG
	ze5gEnTkpQOvEo+iFhYBzXgZ8s7g/MM5mlVPgkpb3Y7hhF08la/X/n0Tc8SfUdTMYpeWCCnacjD
	iHXc3xASDXNLTvJ/Q2B4OcbPCeyHTC68na/FF9tdHBwtySKJ7izbQOBLyORNuFP6XHvD/dGb+EH
	Z3o7gLcoJmT3+jwtu3ROZmvnMhuialZduGhuEmoDJBUQFMKOSaTXYT/spSl70B/z3YMPBhciJuj
	r5zPSec2NXaXN5AvRNtsn9fbYu5H4fwILw7r2OELWI2WEUGlEfLT3ZFuwnLA2VpW7YqhxZFfimh
	2ZKW/Ge5BKUa9XzkJwbthB2I04ESEvgKyPkPpOriboP8pvnWK8ztkyQZB1EFaHgziqsNoiXzhwf
	Z+3B804ZHnB4IZHgHsN3YiowfwUsnmL+BcSMMOW7jpU/pn+zrY7CT4YJX5iSBSAEm0JyACiAamH
	g+OfMJqQMDa2mxUB/nKc7DiwYLuaqdwUTOTVdVqxprZETqAY3wSoBkXaUgkWrwqm+EDjpmq3Ty0
	ADDDA+wGn6Q0j24=
X-Received: by 2002:a05:6a00:2ea9:b0:837:e9cc:d46e with SMTP id d2e1a72fcca58-84c292ab439mr13591102b3a.21.1784532159587;
        Mon, 20 Jul 2026 00:22:39 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-b.c.z168d0f9edf9bc766-tp.internal (43.173.126.34.bc.googleusercontent.com. [34.126.173.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de26a5sm4064176a12.22.2026.07.20.00.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:39 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH 0/2] io_uring: add removexattr and listxattr support
Date: Mon, 20 Jul 2026 07:22:11 +0000
Message-ID: <20260720072213.2719-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series completes io_uring's xattr feature parity by adding support
for the remaining four xattr operations:
- IORING_OP_REMOVEXATTR
- IORING_OP_FREMOVEXATTR
- IORING_OP_LISTXATTR
- IORING_OP_FLISTXATTR

Historically, applications looking to achieve zero-blocking metadata
management had to fall back to synchronous threads to list or prune
extended attributes. This is particularly problematic for highly secure
layered filesystems, active monitoring engines, or container runtimes
utilizing namespace isolation xattrs.

To support this cleanly and reuse existing optimal VFS-layer code paths:
- Patch 1 makes the necessary listxattr/removexattr VFS-layer helpers
  non-static and exposes them in fs/internal.h.
- Patch 2 implements the io_uring operational support (opcodes, opdefs,
  preparation, and issue handlers) and invokes these exposed helpers.

This approach ensures zero code duplication, robust filename handling,
and maintains design consistency across both subsystems.

Testing
=======
A self-contained test program is provided below to verify the
correctness of the new operations (IORING_OP_REMOVEXATTR,
IORING_OP_FREMOVEXATTR, IORING_OP_LISTXATTR, and IORING_OP_FLISTXATTR)
and to ensure proper error and memory handling.

Compilation (completely self-contained, no dependencies on liburing or
updated system headers):
  gcc -O2 -Wall test_uring_xattr.c -o test_uring_xattr

Running:
  ./test_uring_xattr

Test Code (test_uring_xattr.c):
---
// SPDX-License-Identifier: MIT OR GPL-2.0-only
/*
 * Copyright (c) 2026 Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
 *
 * Standalone test harness for verifying io_uring listxattr and removexattr
 * operations (IORING_OP_LISTXATTR, IORING_OP_FLISTXATTR, IORING_OP_REMOVEXATTR,
 * and IORING_OP_FREMOVEXATTR).
 *
 * COMPILATION INSTRUCTIONS:
 *
 * This test harness is completely self-contained, has NO dependencies on
 * liburing, and works with standard system-installed headers (independent
 * of the kernel source tree or any header installations).
 *
 * To compile:
 *
 *   gcc -O2 -Wall test_uring_xattr.c -o test_uring_xattr
 *
 * RUNNING THE TESTS:
 *
 * Ensure you are running on a kernel booted with the new xattr support, then:
 *
 *   ./test_uring_xattr
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/syscall.h>
#include <sys/mman.h>
#include <sys/xattr.h>

#include <linux/io_uring.h>

/* Fallback definitions for compilation on systems with older kernel headers */
#ifndef IORING_OP_REMOVEXATTR
#define IORING_OP_REMOVEXATTR 65
#endif
#ifndef IORING_OP_FREMOVEXATTR
#define IORING_OP_FREMOVEXATTR 66
#endif
#ifndef IORING_OP_LISTXATTR
#define IORING_OP_LISTXATTR 67
#endif
#ifndef IORING_OP_FLISTXATTR
#define IORING_OP_FLISTXATTR 68
#endif

/*
 * Helper to set the 'addr3' field of struct io_uring_sqe.
 *
 * In older kernel headers, the struct io_uring_sqe did not have the 'addr3'
 * field, but the 64-byte layout has remained identical. The 'addr3' field
 * resides at an offset of exactly 48 bytes from the start of the struct.
 * Using this helper ensures the file compiles cleanly on any system.
 */
static inline void sqe_set_addr3(struct io_uring_sqe *sqe, unsigned long val)
{
	*(unsigned long long *)((char *)sqe + 48) = (unsigned long long)val;
}

struct io_uring_params_local {
	unsigned int sq_entries;
	unsigned int cq_entries;
	unsigned int flags;
	unsigned int sq_thread_cpu;
	unsigned int sq_thread_idle;
	unsigned int features;
	unsigned int wq_fd;
	unsigned int resv[3];
	struct io_sqring_offsets sq_off;
	struct io_cqring_offsets cq_off;
};

struct app_ring {
	int ring_fd;
	unsigned int *sq_head;
	unsigned int *sq_tail;
	unsigned int *sq_ring_mask;
	unsigned int *sq_array;
	struct io_uring_sqe *sqes;

	unsigned int *cq_head;
	unsigned int *cq_tail;
	unsigned int *cq_ring_mask;
	struct io_uring_cqe *cqes;
};

static int app_ring_setup(struct app_ring *ring)
{
	struct io_uring_params_local p;
	memset(&p, 0, sizeof(p));

	int fd = syscall(__NR_io_uring_setup, 1, &p);
	if (fd < 0) {
		perror("io_uring_setup");
		return -1;
	}
	ring->ring_fd = fd;

	/* Mmap SQ ring */
	void *sq_ptr = mmap(NULL, p.sq_off.array + p.sq_entries * sizeof(unsigned int),
			    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_SQ_RING);
	if (sq_ptr == MAP_FAILED) {
		perror("mmap SQ ring");
		return -1;
	}

	ring->sq_head = sq_ptr + p.sq_off.head;
	ring->sq_tail = sq_ptr + p.sq_off.tail;
	ring->sq_ring_mask = sq_ptr + p.sq_off.ring_mask;
	ring->sq_array = sq_ptr + p.sq_off.array;

	/* Mmap SQEs */
	void *sqes_ptr = mmap(NULL, p.sq_entries * sizeof(struct io_uring_sqe),
			      PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_SQES);
	if (sqes_ptr == MAP_FAILED) {
		perror("mmap SQEs");
		return -1;
	}
	ring->sqes = sqes_ptr;

	/* Mmap CQ ring */
	void *cq_ptr = mmap(NULL, p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe),
			    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_CQ_RING);
	if (cq_ptr == MAP_FAILED) {
		perror("mmap CQ ring");
		return -1;
	}

	ring->cq_head = cq_ptr + p.cq_off.head;
	ring->cq_tail = cq_ptr + p.cq_off.tail;
	ring->cq_ring_mask = cq_ptr + p.cq_off.ring_mask;
	ring->cqes = cq_ptr + p.cq_off.cqes;

	return 0;
}

static int submit_and_wait(struct app_ring *ring, struct io_uring_sqe *sqe, struct io_uring_cqe *cqe_out)
{
	unsigned int tail = *ring->sq_tail;
	unsigned int mask = *ring->sq_ring_mask;
	unsigned int index = tail & mask;

	/* Copy SQE into SQ ring */
	memcpy(&ring->sqes[index], sqe, sizeof(*sqe));
	ring->sq_array[index] = index;

	/* Advance tail */
	*ring->sq_tail = tail + 1;

	/* Enter kernel to submit and wait for 1 CQE */
	int ret = syscall(__NR_io_uring_enter, ring->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, NULL, 0);
	if (ret < 0) {
		perror("io_uring_enter");
		return -1;
	}

	/* Read CQE */
	unsigned int head = *ring->cq_head;
	unsigned int cq_mask = *ring->cq_ring_mask;
	if (head == *ring->cq_tail) {
		fprintf(stderr, "No CQE available after enter!\n");
		return -1;
	}

	memcpy(cqe_out, &ring->cqes[head & cq_mask], sizeof(*cqe_out));

	/* Advance head */
	*ring->cq_head = head + 1;

	return 0;
}

static void handle_cqe_error(const char *op_name, int res)
{
	fprintf(stderr, "[-] %s failed with CQE error: %s (%d)\n", op_name, strerror(-res), res);
	if (res == -EINVAL || res == -EOPNOTSUPP) {
		fprintf(stderr, "    HINT: The running kernel does not appear to support the new '%s' operation.\n"
		                "          Please verify that you are running a kernel booted with the new listxattr/removexattr io_uring support.\n", op_name);
	}
}

int main(void)
{
	const char *filepath = "testfile.txt";
	const char *attr_name = "user.test_key";
	const char *attr_val = "test_val";
	char buffer[256];

	/* Create temporary file */
	int fd = open(filepath, O_CREAT | O_RDWR | O_TRUNC, 0644);
	if (fd < 0) {
		perror("open file");
		return 1;
	}

	/* Set initial xattr using standard system call */
	if (setxattr(filepath, attr_name, attr_val, strlen(attr_val) + 1, 0) < 0) {
		perror("setxattr");
		close(fd);
		unlink(filepath);
		return 1;
	}

	/* Setup io_uring */
	struct app_ring ring;
	if (app_ring_setup(&ring) < 0) {
		close(fd);
		unlink(filepath);
		return 1;
	}

	struct io_uring_sqe sqe;
	struct io_uring_cqe cqe;

	printf("[*] Starting io_uring removexattr and listxattr test...\n");

	/* --- Test 1: IORING_OP_LISTXATTR --- */
	printf("[+] Testing IORING_OP_LISTXATTR...\n");
	memset(&sqe, 0, sizeof(sqe));
	sqe.opcode = IORING_OP_LISTXATTR;
	sqe.addr2 = (unsigned long)buffer;
	sqe.len = sizeof(buffer);
	sqe_set_addr3(&sqe, (unsigned long)filepath);

	if (submit_and_wait(&ring, &sqe, &cqe) < 0) {
		goto err;
	}

	if (cqe.res < 0) {
		handle_cqe_error("IORING_OP_LISTXATTR", cqe.res);
		goto err;
	}

	printf("[+] IORING_OP_LISTXATTR success, read %d bytes\n", cqe.res);
	/* Search for our attribute name in the listed names (\0-separated) */
	int found = 0;
	for (int i = 0; i < cqe.res; i += strlen(buffer + i) + 1) {
		if (strcmp(buffer + i, attr_name) == 0) {
			found = 1;
			break;
		}
	}
	if (!found) {
		fprintf(stderr, "[-] IORING_OP_LISTXATTR did not find user.test_key in listed keys!\n");
		goto err;
	}
	printf("[+] IORING_OP_LISTXATTR correctly listed user.test_key\n");

	/* --- Test 2: IORING_OP_FLISTXATTR --- */
	printf("[+] Testing IORING_OP_FLISTXATTR...\n");
	memset(&sqe, 0, sizeof(sqe));
	memset(buffer, 0, sizeof(buffer));
	sqe.opcode = IORING_OP_FLISTXATTR;
	sqe.fd = fd;
	sqe.addr2 = (unsigned long)buffer;
	sqe.len = sizeof(buffer);

	if (submit_and_wait(&ring, &sqe, &cqe) < 0) {
		goto err;
	}

	if (cqe.res < 0) {
		handle_cqe_error("IORING_OP_FLISTXATTR", cqe.res);
		goto err;
	}

	printf("[+] IORING_OP_FLISTXATTR success, read %d bytes\n", cqe.res);
	found = 0;
	for (int i = 0; i < cqe.res; i += strlen(buffer + i) + 1) {
		if (strcmp(buffer + i, attr_name) == 0) {
			found = 1;
			break;
		}
	}
	if (!found) {
		fprintf(stderr, "[-] IORING_OP_FLISTXATTR did not find user.test_key!\n");
		goto err;
	}
	printf("[+] IORING_OP_FLISTXATTR correctly listed user.test_key\n");

	/* --- Test 3: IORING_OP_REMOVEXATTR --- */
	printf("[+] Testing IORING_OP_REMOVEXATTR...\n");
	memset(&sqe, 0, sizeof(sqe));
	sqe.opcode = IORING_OP_REMOVEXATTR;
	sqe.addr = (unsigned long)attr_name;
	sqe_set_addr3(&sqe, (unsigned long)filepath);

	if (submit_and_wait(&ring, &sqe, &cqe) < 0) {
		goto err;
	}

	if (cqe.res < 0) {
		handle_cqe_error("IORING_OP_REMOVEXATTR", cqe.res);
		goto err;
	}
	printf("[+] IORING_OP_REMOVEXATTR success\n");

	/* Verify attribute is gone */
	if (getxattr(filepath, attr_name, buffer, sizeof(buffer)) >= 0 || errno != ENODATA) {
		fprintf(stderr, "[-] Attribute user.test_key was not removed!\n");
		goto err;
	}
	printf("[+] Verified: attribute is gone\n");

	/* Reset attribute */
	if (setxattr(filepath, attr_name, attr_val, strlen(attr_val) + 1, 0) < 0) {
		perror("setxattr reset");
		goto err;
	}

	/* --- Test 4: IORING_OP_FREMOVEXATTR --- */
	printf("[+] Testing IORING_OP_FREMOVEXATTR...\n");
	memset(&sqe, 0, sizeof(sqe));
	sqe.opcode = IORING_OP_FREMOVEXATTR;
	sqe.fd = fd;
	sqe.addr = (unsigned long)attr_name;

	if (submit_and_wait(&ring, &sqe, &cqe) < 0) {
		goto err;
	}

	if (cqe.res < 0) {
		handle_cqe_error("IORING_OP_FREMOVEXATTR", cqe.res);
		goto err;
	}
	printf("[+] IORING_OP_FREMOVEXATTR success\n");

	/* Verify attribute is gone again */
	if (getxattr(filepath, attr_name, buffer, sizeof(buffer)) >= 0 || errno != ENODATA) {
		fprintf(stderr, "[-] Attribute user.test_key was not removed via FREMOVEXATTR!\n");
		goto err;
	}
	printf("[+] Verified: attribute is gone again\n");

	printf("\n[***] ALL TESTS PASSED SUCCESSFULLY! [***]\n");

	close(fd);
	unlink(filepath);
	return 0;

err:
	close(fd);
	unlink(filepath);
	return 1;
}
---

Aditya Prakash Srivastava (2):
  fs: make listxattr and removexattr helpers non-static
  io_uring: add removexattr and listxattr support

 fs/internal.h                       |   7 ++
 fs/xattr.c                          |   8 +-
 include/uapi/linux/io_uring.h       |   4 +
 io_uring/opdef.c                    |  34 +++++++
 io_uring/xattr.c                    | 151 ++++++++++++++++++++++++++++
 io_uring/xattr.h                    |  12 +++
 tools/include/uapi/linux/io_uring.h |  15 +++
 7 files changed, 226 insertions(+), 5 deletions(-)

-- 
2.47.3

