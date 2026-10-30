Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793326299;
	b=2PKD+3tkFU4Tm+pC0Ltree9fV+58MN/E2KfFliQQMLQNLXIfOtZ94bXK3lHHdW1sZycl
	 cyHeeDBNgoa/i7bOHzz4HcHfamHd68jcdaKNt9BZd3Yj6npc288XsfVvjpesS1HWImGEO
	 wmeyytW7B/oHS13JJd00afl30f6OhDCB9ToaUnuP1r7gV7fAeP5CFvytwqMOVn0bLo/UP
	 qU9F8InYq4ejmYLW4tOexagAELAw+/LcK8gMxHEuQ1sOUC9vqm/RdUYqhQeu3p93K/9TM
	 rfCtgZI07tqwDTft01WJDo2RQNKA5tC2Z4i6nonSa0zVZYvZu73/gfiuufSZfVAeBnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793326299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=crA/drrVuPBte8rst5YBRjdG8mKRZAGvubjNLACa7Rk=;
	b=crYFqMEEQJMEjdMUhM92FXUa+bSTVgj7oZTk/QpzyXF0JYLZ3U2XAnNCUQJZsIlNwk29
	 TY7nyxx0nsAi+j5N5loumT7cTXTWISvzlZPd5nfy56Pwf3vVMu+EOOKr1+HwyXvwKO5wK
	 +cKc8+jEwED+6lcDAOwueeZ6o3Q4GCv7cX+rFd2asoHTtcnhN40v/PES0LkCy+e+rSS1W
	 nxnjMAvEKzxKEP3DRxsCjY68zk9wm1/LC0X0f2KKqv8pS9o1+Wd5tjanU0AG22h5Ay3dm
	 VXlbj4FgqQD8SMw+4AnLWbfWjdL9CUs2THH5kfnFj3tnSUW/UnGTdERpvzNWlpodZLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ifTtfM4j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18929606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 02:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18929606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ifTtfM4j
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bfc346401aso195764e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 19:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793326297; cv=none;
        d=google.com; s=arc-20260327;
        b=fBfpxveIqdbh32GpfxvBP9VnVCRRU3U3Md+auxGZHrPucIHJJajQq7o8o68CBzp/oZ
         B9oRQsCMAO3Qu9NVOX7KdxdWmTzMJ28UCKCpcFa+z4uDG6HcyQRGAayhcLhgsWxg/8e0
         J8ko0zmiCQI1rVz2HWbqBj7WlRbF2JBgxkhcBi+E683NZgFvF9WUpR/FikQ0N9QEJlMC
         FlYlRx6MpmmaeSo6ykf5vgjKAxF8mrrjtwtzeT7AYrTSHnapYbOH7X8jX+0qr8GPAj62
         qQsVgy2Ftqj7zJvob2MpWiFBTX7RMWFqxJSRkRSZpttf6XFV2HrseqNsBL9+dsOe9sSh
         84bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=crA/drrVuPBte8rst5YBRjdG8mKRZAGvubjNLACa7Rk=;
        fh=5smBEGwMorkZ11Uu8/DQSPMaHzyuppGvDXVO3bAxT1M=;
        b=fO8AhPHCvKSatVwuCEJpcCniqN7tasBqU/rdxtgsDgB2RaWbwvP1DY/hIPp4wwZmIS
         E/HH8Ks/4Ey+oXrqHWUN0BZyrQCmzrkW6IlbRplfvtkyRhvmIztIGtsyL3MfYqkHF5JS
         H8Zbhnm5t2nhBqjNvZkmw8hnS0OYrQQBoRHfuxjy1m/iTYnmt3epdDtvLdftJvl2xDi8
         fDlfSQKwiGCpjX7r56TXqj/kSkV0roSADks5M7an1k3tMwGNr7evL5pwzVX4pZ7AFwUt
         0ryAmlwA8J6RWkCo7ZYfmVLmXAePGjmpwr5JIkIeVhoc+y/LJJbBMrSENUCZuqo662Nv
         60fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793326297; x=1793931097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=crA/drrVuPBte8rst5YBRjdG8mKRZAGvubjNLACa7Rk=;
        b=ifTtfM4jG3w9YJEW8x6W2wS4hUVwPMieW6d4KnhdiWxcvOyoMnUz6w5OAESexQynsZ
         +PQRxfX30fynZCRhTMqkltSqZzgKRM2v3NI+bObBSc9S8OCT9K7FeDQYe/UfhiLkkRuz
         Hbiu7zum5giUOEx80nKI++xyejO7u9e3CZMdvpPOBtgGhSfy6Z+PNzpt8SvZjb5ARWBu
         KAjN4WjfysIfu+8cIwJe1qBVvhtlL9TdwdlW92Cbij7G6+AJEtmlSnZeFx4wzUN12xvi
         kUQM5Y5IOza7tTRuIM8omT5RMCochFZ9AH1Jf9bWAPAOrF4iTpb4h220W7KuQjq2VuJD
         q4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793326297; x=1793931097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crA/drrVuPBte8rst5YBRjdG8mKRZAGvubjNLACa7Rk=;
        b=wFddUotNSqKQUR8mmZzPk4Wt2Bs1zTOjAKdSkLDcDC70lTsxpWE/PMgOyMj1CM8Omk
         zuV2Ab6dWJGANsbbNAUmbRA2oDTQW1KygzUWMDqhljJy87ySer3jcnxjt1f44vlwmXSg
         pZ2ZYx0NpJ1v5B2qp1ugvIiao6HZz9ukLQ+6LApJSi8VI6F39+UItkKPyfHBwVwf7rrm
         BqbjWrEqXqdsE0fqLcSUTlYRzkj03kMs55Cdrqt9UewuZHtCjnVHrDV3uUZHNFCx8Q5m
         KhvFl3MGohAmMJFx2Fj6d2u7z82LSqYATZgrJ6WSI0KPoV0bEt7mCQ+EXIGT65DzQlW9
         4Jgw==
X-Forwarded-Encrypted: i=1; AKwUvBx13saAohOZJl1QhRTLCPBOuVtzG1YptghyhWWrK+KX0b+HUho13/nUhfiG5+LdZMxYXd8Pw/4TDFrreJVz@vger.kernel.org
X-Gm-Message-State: AFq9FYIKV39kdRdB42aygh3cynYMo6hoxvR0RoVk0u87IbtBmoqMyFyo
	n4+PcAwvAf63Xd775C+3EArVcRfFBSnaP8Ua5YU409r6O/22gfOYTksWi6Znvo9GoazRhfnLVQS
	QOrl4Mbi0kN3AkToM9cS/jA0j4MYdepT5gZ0lavwE
X-Gm-Gg: AYBFou23a+jzdgMBmxEG6CsSvDSpL8Q3sGSr0UL+3cVj+OdijjZiL5xoVX+a8AMbbuD
	HcHU2ddabsWLbkFEyLgWWAAKwCe8Yd/9MLX1mQaRmN7VwbJTjoL0jOF6fJDmOUSSJYihx2Br4CU
	pIvEJTuE23VhDDsT3cDqDs+/qx/wZ0QjzebCw8utS+IxvPjGxYvcdU5BmnttzE6XDbkAVJERR/0
	XiZaPkIjjPDtk3KVC8JHHyKJJ5Y+QoXh/B2t0KxXmCUkSrHhOeFML+rOXYATPvKeCKZ0ZBAK5ie
	A1Es8ImMtehtkF2eHX04jJt2h5JCAivzZfn7uNMI6iW9dAvzX5FHCWOwVexi7p2uaNfh85gascx
	qxWFET3opoIaYvU/0fmP6M35MzcRANEnrQQ==
X-Received: by 2002:a05:6512:15a0:b0:5bf:b93d:a75a with SMTP id
 2adb3069b0e04-5bfd957985dmr184617e87.12.1793326297270; Thu, 29 Oct 2026
 19:11:37 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026220546.3114241-1-skhawaja@google.com> <CALCETrXNEWQNPjtuHnTfVFOafeJ7APXq288Cq16Q5adDNYx9+A@mail.gmail.com>
 <auEksxfAi9lHFXmT@google.com> <CALCETrXDY2e8x2kdr-FQvFLs-Y7FwNozXGDvqqM6yvVA7QLV3g@mail.gmail.com>
 <auPKfqh_YjRU9Ui3@google.com> <CALCETrUEyfvaEGxMHo=c0ia3CDgSxg-YW0_=Z7T31Ou+pvicuQ@mail.gmail.com>
In-Reply-To: <CALCETrUEyfvaEGxMHo=c0ia3CDgSxg-YW0_=Z7T31Ou+pvicuQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 29 Oct 2026 19:11:25 -0700
X-Gm-Features: AclHuK_Ui4UCRhuJ1nc0jCjt9G3iqxf-Duoq7MdeFTqjramIg9lV-Tjp2uHPr1Y
Message-ID: <CALCETrVpEP=HxVqdSP_AgA=U7ignwAgjz5Vi9+Z9dZsX5DXeLw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:26=E2=80=AFPM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Thu, Oct 29, 2026 at 4:16=E2=80=AFPM Samiullah Khawaja <skhawaja@googl=
e.com> wrote:
> >
> > For live update either approach works. If pinned pages cannot be punche=
d
> > or truncated, iommufd can rely on that directly and the seal is not
> > needed. I went with an opt-in seal only to avoid changing existing
> > behaviour. If folks are fine with blocking punch hole and truncate on
> > pinned pages, I can send patches for that instead.
>
> That needs opinions from other people :)
>
> My two cents are that blocking hole punch (or making hole punch fall
> back to writing zeros) seems entirely sensible, but I'm less confident
> I know what to do about truncate.
>

FWIW, I think a demonstration of weird kernel behavior is clearer than
musing based on first principles, so I had a friendly coding agent
write the lovely code at the end of this email. It prints:

Creating and mmapping memfd and registering it
memcpy "Hello, world!" to memfd
MADV_REMOVE the contents
The memfd now contains NULs!
memcpy "memcpy was here" to the memfd
Using io_uring to read the registered buffer
io_uring says: Hello, world!
WRITE_FIXED completed: 15 bytes.

IMO this is utterly disgusting.  It makes logical sense based on how
the kernel works under the hood, but I think it makes no sense at all
as a matter of actual observable behavior.

Unsurprisingly, the behavior is identical if MADV_REMOVE is replaced
with ftruncate(0) + fallocate(size).

I can't shake the feeling that the problem here isn't so much that KHO
+ iommofd doesn't like this but that the behavior in question is
nonsensical.

My system's tmpfs does not appear to support FALLOC_FL_COLLAPSE_RANGE,
which is probably for the best :)

---

#define _GNU_SOURCE 1
#include <linux/io_uring.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/uio.h>
#include <unistd.h>
#include <fcntl.h>
#include <cerrno>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>

[[noreturn]] static void Fail(const char* operation) {
    std::perror(operation);
    std::exit(1);
}

static void* Map(int fd, size_t size, off_t offset) {
    void* p =3D mmap(nullptr, size, PROT_READ | PROT_WRITE, MAP_SHARED,
fd, offset);
    if (p =3D=3D MAP_FAILED) Fail("mmap");
    return p;
}

// Single-threaded, one outstanding request, using the raw Linux io_uring A=
BI.
struct Ring {
    int fd;
    io_uring_params p{};
    char* sq;
    char* cq;
    io_uring_sqe* sqes;
    size_t sq_size, cq_size;

    Ring() {
        fd =3D static_cast<int>(syscall(SYS_io_uring_setup, 2, &p));
        if (fd < 0) Fail("io_uring_setup");
        sq_size =3D p.sq_off.array + p.sq_entries * sizeof(unsigned);
        cq_size =3D p.cq_off.cqes + p.cq_entries * sizeof(io_uring_cqe);
        if (p.features & IORING_FEAT_SINGLE_MMAP) {
            if (cq_size > sq_size) sq_size =3D cq_size;
            cq =3D sq =3D static_cast<char*>(Map(fd, sq_size, IORING_OFF_SQ=
_RING));
        } else {
            sq =3D static_cast<char*>(Map(fd, sq_size, IORING_OFF_SQ_RING))=
;
            cq =3D static_cast<char*>(Map(fd, cq_size, IORING_OFF_CQ_RING))=
;
        }
        sqes =3D static_cast<io_uring_sqe*>(Map(fd, p.sq_entries *
sizeof(*sqes), IORING_OFF_SQES));
    }

    ~Ring() {
        munmap(sqes, p.sq_entries * sizeof(*sqes));
        if (cq !=3D sq) munmap(cq, cq_size);
        munmap(sq, sq_size);
        close(fd);
    }

    int WriteFixed(int output, const char* buffer, unsigned length,
uint64_t offset) {
        auto* tail =3D reinterpret_cast<unsigned*>(sq + p.sq_off.tail);
        const unsigned next =3D *tail;
        const unsigned slot =3D next & *reinterpret_cast<unsigned*>(sq +
p.sq_off.ring_mask);
        io_uring_sqe& entry =3D sqes[slot];
        entry =3D {};
        entry.opcode =3D IORING_OP_WRITE_FIXED;
        entry.fd =3D output;
        entry.off =3D offset;
        entry.addr =3D reinterpret_cast<uintptr_t>(buffer);
        entry.len =3D length;
        entry.buf_index =3D 0;
        reinterpret_cast<unsigned*>(sq + p.sq_off.array)[slot] =3D slot;
        __atomic_store_n(tail, next + 1, __ATOMIC_RELEASE);
        long submitted;
        do {
            submitted =3D syscall(SYS_io_uring_enter, fd, 1, 0, 0, nullptr,=
 0);
        } while (submitted < 0 && errno =3D=3D EINTR);
        if (submitted !=3D 1) {
            if (submitted >=3D 0) errno =3D EIO;
            Fail("io_uring_enter submit");
        }
        auto* head =3D reinterpret_cast<unsigned*>(cq + p.cq_off.head);
        auto* cq_tail =3D reinterpret_cast<unsigned*>(cq + p.cq_off.tail);
        const unsigned current =3D *head;
        while (__atomic_load_n(cq_tail, __ATOMIC_ACQUIRE) =3D=3D current) {
            if (syscall(SYS_io_uring_enter, fd, 0, 1,
IORING_ENTER_GETEVENTS, nullptr, 0) < 0
                && errno !=3D EINTR) Fail("io_uring_enter wait");
        }
        auto* completions =3D reinterpret_cast<io_uring_cqe*>(cq + p.cq_off=
.cqes);
        const int result =3D completions[current &
*reinterpret_cast<unsigned*>(cq + p.cq_off.ring_mask)].res;
        __atomic_store_n(head, current + 1, __ATOMIC_RELEASE);
        return result;
    }
};

int main() {
    printf("Creating and mmapping memfd and registering it\n");
    constexpr size_t size =3D 16 * 1024;
    const int fd =3D memfd_create("registered-buffer", MFD_CLOEXEC);
    if (fd < 0) Fail("memfd_create");
    if (fallocate(fd, 0, 0, size) < 0) Fail("fallocate");
    auto* buffer =3D static_cast<char*>(Map(fd, size, 0));
    Ring ring;
    iovec iov{buffer, size};
    if (syscall(SYS_io_uring_register, ring.fd,
IORING_REGISTER_BUFFERS, &iov, 1) < 0)
        Fail("IORING_REGISTER_BUFFERS");

    printf("memcpy \"Hello, world!\" to memfd\n");
    constexpr char hello[] =3D "Hello, world!";
    std::memcpy(buffer, hello, sizeof(hello));

    printf("MADV_REMOVE the contents\n");
    // MADV_REMOVE operates on whole pages. Remove the entire 16 KiB mappin=
g.
    if (madvise(buffer, size, MADV_REMOVE) < 0) Fail("MADV_REMOVE");
    for (size_t i =3D 0; i < size; ++i) {
        if (buffer[i] !=3D '\0') {
            std::fprintf(stderr, "MADV_REMOVE verification failed at
byte %zu\n", i);
            return 1;
        }
    }
    std::fprintf(stderr, "The memfd now contains NULs!\n");

    printf("memcpy \"memcpy was here\" to the memfd\n");
    constexpr char message[] =3D "memcpy was here";
    std::memcpy(buffer, message, sizeof(message));

    printf("Using io_uring to read the registered buffer\nio_uring says: ")=
;
    fflush(stdout);
    const unsigned length =3D static_cast<unsigned>(std::strlen(message));
    int result =3D ring.WriteFixed(STDOUT_FILENO, buffer, length, UINT64_MA=
X);
    if (result < 0) {
        Fail("WRITE_FIXED");
    }
    if (result !=3D static_cast<int>(length)) {
        std::fprintf(stderr, "Short WRITE_FIXED: %d of %u bytes\n",
result, length);
        return 1;
    }
    std::fprintf(stderr, "\nWRITE_FIXED completed: %d bytes.\n", result);
    if (syscall(SYS_io_uring_register, ring.fd,
IORING_UNREGISTER_BUFFERS, nullptr, 0) < 0)
        Fail("IORING_UNREGISTER_BUFFERS");
    munmap(buffer, size);
    close(fd);
}

--=20
Andy Lutomirski
AMA Capital Management, LLC
